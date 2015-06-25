package com.portlet.estimationcalculator.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.portlet.PortletConfig;
import javax.portlet.PortletRequest;
import javax.portlet.PortletResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.MimeTypesUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.servlet.ServletResponseUtil;

public class ExportUtil {

	public static void exportXLS(ResourceRequest resourceRequest,
			ResourceResponse resourceResponse, Locale locale,
			PortletConfig portletConfig, String namealias, String minEstalias,
			String nominalEstalias, String maxEstalias,
			String expectedDeviationalias, String expectedDurationalias,
			String sumOfProbabilityDistributions, String finalEstimation,
			String project) throws IOException {
		Map<String, List<String>> data = prepareDataForExport(namealias,
				minEstalias, nominalEstalias, maxEstalias,
				expectedDeviationalias, expectedDurationalias);
		
		HSSFWorkbook workbook = populateXLS(locale, portletConfig,
				sumOfProbabilityDistributions, finalEstimation, project, data);	
		
		if(_log.isDebugEnabled()){
			_log.debug("XLS created.");
		}
		
		byte[] workbookBytes=getWorkBookBytes(workbook);
				
		sendFile(workbookBytes,"estimation.xls",resourceRequest,resourceResponse);
	}

	private static HSSFWorkbook populateXLS(Locale locale,
			PortletConfig portletConfig, String sumOfProbabilityDistributions,
			String finalEstimation, String project,
			Map<String, List<String>> data) {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("Estimation");
		
		Row row = sheet.createRow(0);		
		Cell cell = row.createCell(0);			        
        cell.setCellValue("Project: "+project);	
		
		Set<String> keyset = data.keySet();
		int rownum = 2;
		for (String key : keyset) {
		    row = sheet.createRow(rownum++);
		    List<String> objArr = data.get(key);
		    int cellnum = 0;
		    for (Object obj : objArr) {
		        cell = row.createCell(cellnum++);			        
		        cell.setCellValue((String)obj);		        	        	
		    }
		}

		row = sheet.createRow(++rownum);
		cell = row.createCell(0);			        
		cell.setCellValue(LanguageUtil.format(portletConfig, locale,
				"result-message", new String[] { sumOfProbabilityDistributions,
						finalEstimation }));
		return workbook;
	}

	private static Map<String, List<String>> prepareDataForExport(String namealias,
			String minEstalias, String nominalEstalias, String maxEstalias,
			String expectedDeviationalias, String expectedDurationalias) {
		List<String> namealiasList=Arrays.asList(StringUtil.split(namealias,"$"));
		List<String> minEstaliasList=Arrays.asList(StringUtil.split(minEstalias,"$"));
		List<String> nominalEstaliasList=Arrays.asList(StringUtil.split(nominalEstalias,"$"));
		List<String> maxEstaliasList=Arrays.asList(StringUtil.split(maxEstalias,"$"));
		List<String> expectedDeviationaliasList=Arrays.asList(StringUtil.split(expectedDeviationalias,"$"));
		List<String> expectedDurationaliasList=Arrays.asList(StringUtil.split(expectedDurationalias,"$"));
					
		Iterator<String> namealiasListIt = namealiasList.iterator();
		Iterator<String> minEstaliasListIt = minEstaliasList.iterator();
		Iterator<String> nominalEstaliasListIt = nominalEstaliasList.iterator();
		Iterator<String> maxEstaliasListIt = maxEstaliasList.iterator();
		Iterator<String> expectedDeviationaliasListIt = expectedDeviationaliasList.iterator();
		Iterator<String> expectedDurationaliasListIt = expectedDurationaliasList.iterator();
		
		List<String> columnNamesList=new ArrayList<String>();
		columnNamesList.add("Task Name");
		columnNamesList.add("Optimistic Estimate");
		columnNamesList.add("Nominal Estimate");
		columnNamesList.add("Pessimistic Estimate");
		columnNamesList.add("Expected Duration");
		columnNamesList.add("Standard Deviation");
		
		Map<String, List<String>> data = new  LinkedHashMap<String, List<String>>();
		data.put("0",columnNamesList);		

		List<String> pivotedData=Collections.emptyList();
		int i=1;
		while (namealiasListIt.hasNext() && minEstaliasListIt.hasNext()
				&& nominalEstaliasListIt.hasNext()
				&& maxEstaliasListIt.hasNext()
				&& expectedDurationaliasListIt.hasNext()
				&& expectedDeviationaliasListIt.hasNext()) {
			
			pivotedData=new ArrayList<String>();
			pivotedData.add(namealiasListIt.next());
			pivotedData.add(minEstaliasListIt.next());
			pivotedData.add(nominalEstaliasListIt.next());
			pivotedData.add(maxEstaliasListIt.next());
			pivotedData.add(expectedDurationaliasListIt.next());
			pivotedData.add(expectedDeviationaliasListIt.next());
			
			data.put(String.valueOf(i),pivotedData);
			i++;
		}
		return data;
	}
	
	private static byte[] getWorkBookBytes(HSSFWorkbook workbook) throws IOException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream( );		
	    workbook.write(outputStream);
		byte[] bytes = outputStream.toByteArray();
		outputStream.close();
		return bytes;
	}
	
	private static void sendFile(
		byte[] bytes, String fileName,
		PortletRequest portletRequest, PortletResponse portletResponse)
		throws IOException {
			
		HttpServletRequest request = PortalUtil.getHttpServletRequest(portletRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(portletResponse);
				
		String contentType = MimeTypesUtil.getContentType(fileName);
		ServletResponseUtil.sendFile(request, response, fileName, bytes, contentType);		
	}
	private static Log _log = LogFactoryUtil.getLog(ExportUtil.class);
}
