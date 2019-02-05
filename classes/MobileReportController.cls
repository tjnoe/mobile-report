// Page Controller for the MobileReport page.
global with sharing class MobileReportController {
    
    public MobileReportController() { }
    
    @RemoteAction
    global static String getReportMetadata(String reportId, List<FilterParam> filterParams) {
        // Check if reportId is blank 
        if (!String.isBlank(reportId)) {
            Reports.ReportMetadata reportMd = Reports.ReportManager.describeReport(reportId).getReportMetadata();
            for (FilterParam fp : filterParams) {
                if ((fp.index).isNumeric() && Integer.valueOf(fp.index) < reportMd.getReportFilters().size()) {
                	Reports.ReportFilter filter = reportMd.getReportFilters()[Integer.valueOf(fp.index)];
					filter.setValue(fp.value);    
                }
            }
            Reports.reportResults results = Reports.ReportManager.runReport(reportId, reportMd, true);
            return JSON.serialize(results);
        } else {
            return generateErrorJSON('No report ID was provided. Please provide a report ID in the query parameters.');
        }
    }
    
    global class FilterParam {
        public String index {get; set;}
        public String value {get; set;}
        
        public FilterParam(String idx, String val) {
            index = idx;
            value = val;
        }
    }
    
    private static String generateErrorJSON(String errorMessage) {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('error', errorMessage);
        gen.writeEndObject();
        return gen.getAsString();
    }
    
}