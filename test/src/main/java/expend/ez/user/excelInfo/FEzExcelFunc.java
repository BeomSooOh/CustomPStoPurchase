package expend.ez.user.excelInfo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;


@Component ( "TestExcelView" )
public class FEzExcelFunc extends AbstractExcelView {

	@SuppressWarnings ( "resource" )
	@Override
	protected void buildExcelDocument ( Map<String, Object> model, HSSFWorkbook wb, HttpServletRequest req, HttpServletResponse resp ) throws Exception {
		@SuppressWarnings ( "unused" )
		DateFormat dateFormat = new SimpleDateFormat( "yyyy-MM-dd", Locale.getDefault() );
		HSSFWorkbook workbook = new HSSFWorkbook( );
		HSSFSheet sheet = workbook.createSheet( );
		HSSFRow header = sheet.createRow( 0 );
		header.createCell( (short) 0 ).setCellValue( "Test1" );
		header.createCell( (short) 1 ).setCellValue( "Test2" );
		header.createCell( (short) 2 ).setCellValue( "Test3" );
		header.createCell( (short) 3 ).setCellValue( "Test4" );
		header.createCell( (short) 4 ).setCellValue( "Test5" );
		HSSFRow row = sheet.createRow( 1 );
		row.createCell( (short) 0 ).setCellValue( "Test1" );
		row.createCell( (short) 1 ).setCellValue( "Test2" );
		row.createCell( (short) 2 ).setCellValue( "Test3" );
		row.createCell( (short) 3 ).setCellValue( "Test4" );
		row.createCell( (short) 4 ).setCellValue( "Test5" );
	}
}
