package purchase.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface ContractService {

	public Map<String, Object> InsertContract ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
	
	public Map<String, Object> InsertConclusion ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
	
	public Map<String, Object> InsertConclusionChange ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
	
}
