package common.helper.excel;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellUtil;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;


@Service ( "CommonExcel" )
public class CommonExcel {
	/* 변수정의 */

    private final static int GMAXTHREADSLEEPCOUNT = 100; // 엑셀 다운로드 시 Thread.sleep을 실행할 기준 카운트
    private final static int GSLEEPBASETIME = 100; // Thread.slep 시간

	/* Excel 파일 생성
	 * data : 엑셀 파일 생성시 참고할 데이터
	 * header : 엑셀 헤더 정의( key값으로 데이터에서 값을 가져오며 헤더에는 value값이 표시가 된다.
	 * fileFullName : t_co_group_path에 있는 지출결의 경로 + temp/excel/ + 파일명 + 확장자 (예: d:/upload/expend/temp/excel/카드사용현황20170925.xlsx)
	 *  */
	@SuppressWarnings("deprecation")
	public static boolean CreateExcelFile ( List<Map<String, Object>> data, Map<String, Object> params, String filePath, String name ) throws Exception {
		/* 변수 정의 */
		boolean isSuccess = true;
		if( data == null || data.size( ) == 0 ){
			return false;
		}
		/* Excel 파일 생성 로직 */
		Map<String, Object> header = new LinkedHashMap<String, Object>( );
		header = CommonConvert.CommonGetJSONToMap( params.get( "excelHeader" ).toString( ) );

		Workbook wb = new SXSSFWorkbook( );
		try {
			Sheet sh = wb.createSheet( );
			int rowIdx = 0;
			int cellIdx = 0;
			/* header 생성 */
			Row headerRow = sh.createRow( rowIdx++ );
			for ( Map.Entry<String, Object> entry : header.entrySet( ) ) {
				Cell cell = headerRow.createCell( cellIdx++ );
				cell.setCellValue( entry.getValue( ).toString( ) );
				CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);
			}
			/* 데이터 개수만큼 반복 실행 */
			/* cell style과 cell format을 뺀 이유는 최대 생성개수가 정해져 있기 때문에 최초 한번만 생성. */
			/* cell 금액 Style 설정 */
			CellStyle cellAmtStyle = wb.createCellStyle( );
			/* cell 날짜 Style 설정 */
			CellStyle cellDateStyle = wb.createCellStyle( );
			/* cell 시간 Style 설정 */
			CellStyle cellTimeStyle = wb.createCellStyle( );
			/* cell 포맷 설정 */
			DataFormat format = wb.createDataFormat( );

			if(data.size() > 20000) {
			  ExpInfo.CoreLogNotLoop("excel 생성 대상 데이터가 20,000건을 초과합니다. 시간이 오래걸리거나, 시스템 장애가 발생될 수 있습니다.", null);
			  throw new Exception("excel 생성 대상 데이터가 20,000건을 초과합니다. 시간이 오래걸러나, 시스템 장애가 발생될 수 있으므로 기능 수행이 차단됩니다.");
			}

			int idxOf = 0;

			for ( Map<String, Object> map : data ) {

				// row 생성
				Row row = sh.createRow( rowIdx++ );
				cellIdx = 0;

				for ( Map.Entry<String, Object> cellData : header.entrySet( ) ) {
					Cell cell = row.createCell( cellIdx++ );
					if ( cellData.getValue( ) != null ) {
						if ( cellData.getKey( ).toLowerCase( ).indexOf( "amt" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "amount" ) > -1 ) {
							/* 금액 콤마 설정 */
							CellType cellType = CellType.NUMERIC;
							cellAmtStyle.setDataFormat( format.getFormat( "#,##0" ) );
							cell.setCellType( cellType );
							cell.setCellStyle( cellAmtStyle );
							if(map.get( cellData.getKey( ) ) == null){
								cell.setCellValue( Double.parseDouble( "0" ) );
							} else if ( map.get( cellData.getKey( ) ).toString( ).equals( "" ) ){
								cell.setCellValue( Double.parseDouble( "0" ) );
							} else{
								cell.setCellValue( Double.parseDouble( CommonConvert.NullToString( map.get( cellData.getKey( ) ) ).replace( ",", "" ) ) );
							}
							CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_RIGHT);


							/* 결의현황 셀병합 처리 ( 송준석, 2020/01/21 )
							 * 강제로 소스에 추가, 추후 정리 필요
							 * */
							if( params.get("tripExcelCode") != null  ){

								String backDocseq = "";
								if(  data.get(rowIdx-2).get("docSeq") != null && idxOf != 0){
									backDocseq = data.get(rowIdx-3).get("docSeq").toString();
								}

								int mergeCnt = 0;
								if( params.get("tripExcelCode").equals("2") ){
									mergeCnt =  Integer.parseInt( map.get("budgetCnt").toString() );
									String thisDocseq =  map.get("docSeq").toString() ;

									if( ( !backDocseq.equals("") && !backDocseq.equals(thisDocseq) && mergeCnt > 1 ) || ( backDocseq.equals("") && mergeCnt > 1 ) ){
										sh.addMergedRegion(new CellRangeAddress(rowIdx-1,rowIdx-1+mergeCnt-1,cellIdx-1,cellIdx-1));
									}

								}else if( params.get("tripExcelCode").equals("3")){
									if( cellData.getKey( ).toLowerCase( ).indexOf( "amtclass1amt" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "amtclass2amt" ) > -1 ||
										cellData.getKey( ).toLowerCase( ).indexOf( "amtclass3amt" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "amtclass4amt" ) > -1 ||
										cellData.getKey( ).toLowerCase( ).indexOf( "amtclass5amt" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "amtclass6amt" ) > -1 ){
										// nothing
									}else{
										mergeCnt =  Integer.parseInt( map.get("userCnt").toString() );
										String thisDocseq =  map.get("docSeq").toString() ;

										if( ( !backDocseq.equals("") && !backDocseq.equals(thisDocseq) && mergeCnt > 1 ) || ( backDocseq.equals("") && mergeCnt > 1 ) ){
											sh.addMergedRegion(new CellRangeAddress(rowIdx-1,rowIdx-1+mergeCnt-1,cellIdx-1,cellIdx-1));
										}
									}
								}
							} // end of if



						}
						else if ( cellData.getKey( ).toLowerCase( ).indexOf( "date" ) > -1 ) {
							/* 년-월-일 설정 (2017-09-15) */
							CellType cellType = CellType.STRING;
							cellDateStyle.setDataFormat( format.getFormat( "m/d/yy" ) );
							cell.setCellType( cellType );
							cell.setCellStyle( cellDateStyle );
							/* Date로 값 넣어야함 */
							String time = CommonConvert.NullToString( map.get( cellData.getKey( ) ) );
							if ( time.length( ) == 8 ) {
								time = time.substring( 0, 4 ) + "-" + time.substring( 4, 6 ) + "-" + time.substring( 6, 8 );
								SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy-MM-dd", Locale.getDefault() );
								Date date = dateFormat.parse( time );
								cell.setCellValue( date );
							}
							else {
								cell.setCellValue( CommonConvert.NullToString( map.get( cellData.getKey( ) ) ) );
							}

							CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);

							/* 결의현황 셀병합 처리 ( 송준석, 2020/01/21 )
							 * 강제로 소스에 추가, 추후 정리 필요
							 * */
							if( params.get("tripExcelCode") != null  ){

								String backDocseq = "";
								if(  data.get(rowIdx-2).get("docSeq") != null && idxOf != 0){
									backDocseq = data.get(rowIdx-3).get("docSeq").toString();
								}

								int mergeCnt = 0;
								if( params.get("tripExcelCode").equals("2") ){
									mergeCnt =  Integer.parseInt( map.get("budgetCnt").toString() );
								}else if( params.get("tripExcelCode").equals("3")){
									mergeCnt =  Integer.parseInt( map.get("userCnt").toString() );
								}

								String thisDocseq =  map.get("docSeq").toString() ;

								if( ( !backDocseq.equals("") && !backDocseq.equals(thisDocseq) && mergeCnt > 1 ) || ( backDocseq.equals("") && mergeCnt > 1 ) ){
									sh.addMergedRegion(new CellRangeAddress(rowIdx-1,rowIdx-1+mergeCnt-1,cellIdx-1,cellIdx-1));
								}
							} // end of if


						}
						else if ( cellData.getKey( ).toLowerCase( ).indexOf( "time" ) > -1 ) {
							/* 시간설정 (11:00:00) */
							CellType cellType = CellType.STRING;
							cellTimeStyle.setDataFormat( format.getFormat( "h:mm:ss" ) );
							cell.setCellType( cellType );
							cell.setCellStyle( cellTimeStyle );
							/* Date로 값 넣어야함 */
							String time = map.get( cellData.getKey( ) ).toString( );
							if ( time.length( ) == 6 ) {
								time = time.substring( 0, 2 ) + ":" + time.substring( 2, 4 ) + ":" + time.substring( 4, 6 );
								SimpleDateFormat dateFormat = new SimpleDateFormat( "hh:mm:ss", Locale.getDefault() );
								Date date = dateFormat.parse( time );
								cell.setCellValue( date );
							}
							else if ( time.length( ) == 4 ) {
								time = time.substring( 0, 2 ) + ":" + time.substring( 2, 4 ) + ":00";
								SimpleDateFormat dateFormat = new SimpleDateFormat( "hh:mm:ss", Locale.getDefault() );
								Date date = dateFormat.parse( time );
								cell.setCellValue( date );
							}
							else {
								cell.setCellValue( map.get( cellData.getKey( ) ).toString( ) );
							}

							CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);

							/* 결의현황 셀병합 처리 ( 송준석, 2020/01/21 )
							 * 강제로 소스에 추가, 추후 정리 필요
							 * */
							if( params.get("tripExcelCode") != null  ){

								String backDocseq = "";
								if(  data.get(rowIdx-2).get("docSeq") != null && idxOf != 0){
									backDocseq = data.get(rowIdx-3).get("docSeq").toString();
								}

								int mergeCnt = 0;
								if( params.get("tripExcelCode").equals("2") ){
									mergeCnt =  Integer.parseInt( map.get("budgetCnt").toString() );
								}else if( params.get("tripExcelCode").equals("3")){
									mergeCnt =  Integer.parseInt( map.get("userCnt").toString() );
								}

								String thisDocseq =  map.get("docSeq").toString() ;

								if( ( !backDocseq.equals("") && !backDocseq.equals(thisDocseq) && mergeCnt > 1 ) || ( backDocseq.equals("") && mergeCnt > 1 ) ){
									sh.addMergedRegion(new CellRangeAddress(rowIdx-1,rowIdx-1+mergeCnt-1,cellIdx-1,cellIdx-1));
								}
							} // end of if


						}
						else {
							if( map.get( cellData.getKey( ) ) == null ){
								cell.setCellValue( commonCode.EMPTYSTR );
							}else{
								cell.setCellValue( map.get( cellData.getKey( ) ).toString( ) );
							}

							CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_LEFT);


							/* 결의현황 셀병합 처리 ( 송준석, 2020/01/21 )
							 * 강제로 소스에 추가, 추후 정리 필요
							 * */
							if( params.get("tripExcelCode") != null  ){

								String backDocseq = "";
								if(  data.get(rowIdx-2).get("docSeq") != null && idxOf != 0){
									backDocseq = data.get(rowIdx-3).get("docSeq").toString();
								}

								int mergeCnt = 0;
								if( params.get("tripExcelCode").equals("2") ){
									if( cellData.getKey( ).toLowerCase( ).indexOf( "bgtname1" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "bgtname2" ) > -1 ||
										cellData.getKey( ).toLowerCase( ).indexOf( "bgtname3" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "bgtname4" ) > -1 ){
										// nothing
									}else{
										mergeCnt =  Integer.parseInt( map.get("budgetCnt").toString() );

										String thisDocseq =  map.get("docSeq").toString() ;

										if( ( !backDocseq.equals("") && !backDocseq.equals(thisDocseq) && mergeCnt > 1 ) || ( backDocseq.equals("") && mergeCnt > 1 ) ){
											sh.addMergedRegion(new CellRangeAddress(rowIdx-1,rowIdx-1+mergeCnt-1,cellIdx-1,cellIdx-1));
										}
									}

								}else if( params.get("tripExcelCode").equals("3")){
									if( cellData.getKey( ).toLowerCase( ).indexOf( "travelertext" ) > -1 ){
										// nothing
									}else{
										mergeCnt =  Integer.parseInt( map.get("userCnt").toString() );

										String thisDocseq =  map.get("docSeq").toString() ;

										if( ( !backDocseq.equals("") && !backDocseq.equals(thisDocseq) && mergeCnt > 1 ) || ( backDocseq.equals("") && mergeCnt > 1 ) ){
											sh.addMergedRegion(new CellRangeAddress(rowIdx-1,rowIdx-1+mergeCnt-1,cellIdx-1,cellIdx-1));
										}
									}
								}
							} // end of if


						}
					}
					else {
						cell.setCellValue( "" );
					}
				}

				if((idxOf % GMAXTHREADSLEEPCOUNT) == 0) {
				  Thread.sleep(GSLEEPBASETIME);
				}

				idxOf++;
			}
			// 출력 파일 위치및 파일명 설정
			FileOutputStream outFile;
			try {
				File file = new File( (filePath + name) );
				if ( !file.exists( ) ) {
					file.mkdirs( );
					file.delete( );
				}
				outFile = new FileOutputStream( file );
				wb.write( outFile );
				outFile.close( );
				//System.out.println( "파일생성 완료" );
			}
			catch ( Exception e ) {
				isSuccess = false;
				e.printStackTrace( );
			}
		}
		catch ( Exception e ) {
			isSuccess = false;
			e.printStackTrace( );
		}
		finally {
			if ( wb != null ) {
				wb.close( );
			}
		}
		return isSuccess;
	}

	@SuppressWarnings("deprecation")
	public static boolean CreateExcelFile_plusSubTable ( List<Map<String, Object>> data, Map<String, Object> params, String filePath, String name ) throws Exception {
		/* 변수 정의 */
		boolean isSuccess = true;
		if( data == null || data.size( ) == 0 ){
			return false;
		}
		/* Excel 파일 생성 로직 */
		Map<String, Object> header = new LinkedHashMap<String, Object>( );
		Map<String, Object> subHeader = new LinkedHashMap<String, Object>( );
		Map<String, Object> subTable = new LinkedHashMap<String, Object>( );
		header = CommonConvert.CommonGetJSONToMap( params.get( "excelHeader" ).toString( ) );
		subHeader = CommonConvert.CommonGetJSONToMap( params.get( "subHeader" ).toString( ) );
		subTable = CommonConvert.CommonGetJSONToMap( params.get( "subTable" ).toString( ) );
		Workbook wb = new SXSSFWorkbook( );

		try {
			Sheet sh = wb.createSheet( );
			int rowIdx = 0;
			int cellIdx = 0;
			/* header 생성 */
			Row subHeaderRow = sh.createRow( rowIdx++ );
			for ( Map.Entry<String, Object> entry : subHeader.entrySet( ) ) {
				Cell cell = subHeaderRow.createCell( cellIdx++ );
				cell.setCellValue( entry.getValue( ).toString( ) );
				CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);
			}

			cellIdx = 0;

			Row subTableRow = sh.createRow( rowIdx++ );
			for ( Map.Entry<String, Object> entry : subTable.entrySet( ) ) {
				Cell cell = subTableRow.createCell( cellIdx++ );
				cell.setCellValue( entry.getValue( ).toString( ) );
				CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);
			}

			rowIdx++;
			cellIdx = 0;

			Row headerRow = sh.createRow( rowIdx++ );
			for ( Map.Entry<String, Object> entry : header.entrySet( ) ) {
				Cell cell = headerRow.createCell( cellIdx++ );
				cell.setCellValue( entry.getValue( ).toString( ) );
				CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);
			}
			/* 데이터 개수만큼 반복 실행 */
			/* cell style과 cell format을 뺀 이유는 최대 생성개수가 정해져 있기 때문에 최초 한번만 생성. */
			/* cell 금액 Style 설정 */
			CellStyle cellAmtStyle = wb.createCellStyle( );
			/* cell 날짜 Style 설정 */
			/* cell 포맷 설정 */
			DataFormat format = wb.createDataFormat( );

			if(data.size() > 20000) {
			  ExpInfo.CoreLogNotLoop("excel 생성 대상 데이터가 20,000건을 초과합니다. 시간이 오래걸리거나, 시스템 장애가 발생될 수 있습니다.", null);
			  throw new Exception("excel 생성 대상 데이터가 20,000건을 초과합니다. 시간이 오래걸러나, 시스템 장애가 발생될 수 있으므로 기능 수행이 차단됩니다.");
			}

			int idxOf = 0;

			for ( Map<String, Object> map : data ) {

				// row 생성
				Row row = sh.createRow( rowIdx++ );
				cellIdx = 0;
				for ( Map.Entry<String, Object> cellData : header.entrySet( ) ) {
					Cell cell = row.createCell( cellIdx++ );
					if ( cellData.getValue( ) != null ) {

						if ( !cellData.getKey().equals("BUD_YM") ) {
							/* 금액 콤마 설정 */
							CellType cellType = CellType.NUMERIC;
							cellAmtStyle.setDataFormat( format.getFormat( "#,##0" ) );
							cell.setCellType( cellType );
							cell.setCellStyle( cellAmtStyle );
							if(map.get( cellData.getKey( ) ) == null){
								cell.setCellValue( Double.parseDouble( "0" ) );
							} else if ( map.get( cellData.getKey( ) ).toString( ).equals( "" ) ){
								cell.setCellValue( Double.parseDouble( "0" ) );
							} else{
								cell.setCellValue( Double.parseDouble( CommonConvert.NullToString( map.get( cellData.getKey( ) ) ).replace( ",", "" ) ) );
							}
							CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_RIGHT);
						}

						else {
							if( map.get( cellData.getKey( ) ) == null ){
								cell.setCellValue( commonCode.EMPTYSTR );
							}else{
								cell.setCellValue( map.get( cellData.getKey( ) ).toString( ) );
							}

							CellUtil.setAlignment(cell, wb, CellStyle.ALIGN_CENTER);
						}
					}
					else {
						cell.setCellValue( "" );
					}
				}

				if((idxOf % GMAXTHREADSLEEPCOUNT) == 0) {
				  Thread.sleep(GSLEEPBASETIME);
				}

				idxOf++;
			}
			// 출력 파일 위치및 파일명 설정
			FileOutputStream outFile;
			try {
				File file = new File( (filePath + name) );
				if ( !file.exists( ) ) {
					file.mkdirs( );
					file.delete( );
				}
				outFile = new FileOutputStream( file );
				wb.write( outFile );
				outFile.close( );
				//System.out.println( "파일생성 완료" );
			}
			catch ( Exception e ) {
				isSuccess = false;
				e.printStackTrace( );
			}
		}
		catch ( Exception e ) {
			isSuccess = false;
			e.printStackTrace( );
		}
		finally {
			if ( wb != null ) {
				wb.close( );
			}
		}
		return isSuccess;
	}


//	public static String CreateExcelFile ( List<Map<String, Object>> data, Map<String, Object> header, String fileFullName ) throws Exception {
//		Workbook wb = new SXSSFWorkbook( );
//		String fileName = fileFullName;
//		try {
//			Sheet sh = wb.createSheet( );
//			int rowIdx = 0;
//			int cellIdx = 0;
//			/* header 생성 */
//			Row headerRow = sh.createRow( rowIdx++ );
//			for ( Map.Entry<String, Object> entry : header.entrySet( ) ) {
//				Cell cell = headerRow.createCell( cellIdx++ );
//				cell.setCellValue( entry.getValue( ).toString( ) );
//			}
//			/* 데이터 개수만큼 반복 실행 */
//			/* cell style과 cell format을 뺀 이유는 최대 생성개수가 정해져 있기 때문에 최초 한번만 생성. */
//			/* cell 금액 Style 설정 */
//			CellStyle cellAmtStyle = wb.createCellStyle( );
//			/* cell 날짜 Style 설정 */
//			CellStyle cellDateStyle = wb.createCellStyle( );
//			/* cell 시간 Style 설정 */
//			CellStyle cellTimeStyle = wb.createCellStyle( );
//			/* cell 포맷 설정 */
//			DataFormat format = wb.createDataFormat( );
//			for ( Map<String, Object> map : data ) {
//				// row 생성
//				Row row = sh.createRow( rowIdx++ );
//				cellIdx = 0;
//				for ( Map.Entry<String, Object> cellData : header.entrySet( ) ) {
//					Cell cell = row.createCell( cellIdx++ );
//					if ( cellData.getValue( ) != null ) {
//						if ( cellData.getKey( ).toLowerCase( ).indexOf( "amt" ) > -1 || cellData.getKey( ).toLowerCase( ).indexOf( "amount" ) > -1 ) {
//							/* 금액 콤마 설정 */
//							CellType cellType = CellType.NUMERIC;
//							cellAmtStyle.setDataFormat( format.getFormat( "#,##0" ) );
//							cell.setCellType( cellType );
//							cell.setCellStyle( cellAmtStyle );
//							cell.setCellValue( Double.parseDouble( map.get( cellData.getKey( ) ).toString( ) ) );
//						}
//						else if ( cellData.getKey( ).toLowerCase( ).indexOf( "date" ) > -1 ) {
//							/* 년-월-일 설정 (2017-09-15) */
//							CellType cellType = CellType.STRING;
//							cellDateStyle.setDataFormat( format.getFormat( "m/d/yy" ) );
//							cell.setCellType( cellType );
//							cell.setCellStyle( cellDateStyle );
//							/* Date로 값 넣어야함 */
//							String time = map.get( cellData.getKey( ) ).toString( );
//							if ( time.length( ) == 8 ) {
//								time = time.substring( 0, 4 ) + "-" + time.substring( 4, 6 ) + "-" + time.substring( 6, 8 );
//								SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy-mm-dd" );
//								Date date = dateFormat.parse( time );
//								cell.setCellValue( date );
//							}
//							else {
//								cell.setCellValue( map.get( cellData.getKey( ) ).toString( ) );
//							}
//						}
//						else if ( cellData.getKey( ).toLowerCase( ).indexOf( "time" ) > -1 ) {
//							/* 시간설정 (11:00:00) */
//							CellType cellType = CellType.STRING;
//							cellTimeStyle.setDataFormat( format.getFormat( "h:mm:ss" ) );
//							cell.setCellType( cellType );
//							cell.setCellStyle( cellTimeStyle );
//							/* Date로 값 넣어야함 */
//							String time = map.get( cellData.getKey( ) ).toString( );
//							if ( time.length( ) == 6 ) {
//								time = time.substring( 0, 2 ) + ":" + time.substring( 2, 4 ) + ":" + time.substring( 4, 6 );
//								SimpleDateFormat dateFormat = new SimpleDateFormat( "hh:mm:ss" );
//								Date date = dateFormat.parse( time );
//								cell.setCellValue( date );
//							}
//							else if ( time.length( ) == 4 ) {
//								time = time.substring( 0, 2 ) + ":" + time.substring( 2, 4 ) + ":00";
//								SimpleDateFormat dateFormat = new SimpleDateFormat( "hh:mm:ss" );
//								Date date = dateFormat.parse( time );
//								cell.setCellValue( date );
//							}
//							else {
//								cell.setCellValue( map.get( cellData.getKey( ) ).toString( ) );
//							}
//						}
//						else {
//							cell.setCellValue( map.get( cellData.getKey( ) ).toString( ) );
//						}
//					}
//					else {
//						cell.setCellValue( "" );
//					}
//				}
//			}
//			// 출력 파일 위치및 파일명 설정
//			FileOutputStream outFile;
//			try {
//				File file = new File( fileName );
//				if ( !file.exists( ) ) {
//					file.mkdirs( );
//					file.delete( );
//				}
//				outFile = new FileOutputStream( file );
//				wb.write( outFile );
//				outFile.close( );
//				System.out.println( "파일생성 완료" );
//			}
//			catch ( Exception e ) {
//				e.printStackTrace( );
//			}
//		}
//		catch ( Exception e ) {
//			e.printStackTrace( );
//		}
//		finally {
//			if ( wb != null ) {
//				wb.close( );
//			}
//		}
//		return fileName;
//	}

	/* JSP에서 Excel 파일 다운로드 */
	/* resultFileName : 전체 경로 + 파일명칭 + 확장자
	 * fileName : 파일명칭 + 확장자 */
	public static void ExcelDownload ( FileInputStream fisO, BufferedInputStream inO, ByteArrayOutputStream bStreamO, String resultFileName, String fileName, HttpServletRequest request, HttpServletResponse response){
		File returnFile = new File( resultFileName );
		String showUserFileName = fileName.split( "_" )[0] + ".xlsx";

		FileInputStream fis = fisO;
		BufferedInputStream in = inO;
		ByteArrayOutputStream bStream = bStreamO;


		try{
			fis = new FileInputStream( returnFile );
			in = new BufferedInputStream( fis );
			bStream = new ByteArrayOutputStream( );

			int imgByte;
			byte buffer[] = new byte[4096];
			while( ( imgByte = in.read( buffer )) != -1 ){
				bStream.write( buffer, 0, imgByte );
			}

			String browser = request.getHeader( "User-Agent" );

			//파일 인코딩
		    if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Edge")){
		    	showUserFileName = URLEncoder.encode(showUserFileName,"UTF-8").replaceAll("\\+", "%20");
		    }
		    else {
		    	showUserFileName = new String(showUserFileName.getBytes("UTF-8"), "ISO-8859-1");
		    }

		    response.setHeader("Content-Disposition","attachment;filename=\"" + showUserFileName+"\"");
		    response.setContentLength(bStream.size());

		    response.setContentType("application/octer-stream");
		    response.setHeader("Content-Transfer-Encoding", "binary;");


			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();
		}catch ( Exception e ) {
			e.printStackTrace( );
		} finally {
			if (bStream != null) {
				try {
					bStream.close();
				} catch (Exception ignore) {
					// LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (Exception ignore) {
					// LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception ignore) {
					// LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
		}

	}
}
