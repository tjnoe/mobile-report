// Test class for the MobileReportController class.
// NOTE: SeeAllData='true' required to query reports.
@isTest(SeeAllData='true')
public class MobileReportControllerTest {
    
    @isTest static void testGetReportMetadataNoFilters() {
        List <Report> reportList = [SELECT Id FROM Report LIMIT 1];
        String reportId = (String)reportList.get(0).get('Id');
        String reportMetadataJSON = MobileReportController.getReportMetadata(reportId, new List<MobileReportController.FilterParam>());
        Map<String, Object> reportMap = (Map<String, Object>) JSON.deserializeUntyped(reportMetadataJSON);
        System.assert(reportMap.get('reportMetadata') != null);
    }
    
    @isTest static void testGetReportMetadataWithFilters() {
        List <Report> reportList = [SELECT Id FROM Report LIMIT 1];
        String reportId = (String)reportList.get(0).get('Id');
        List<MobileReportController.FilterParam> fps = new List<MobileReportController.FilterParam>();
        MobileReportController.FilterParam fp = new MobileReportController.FilterParam('0', '0123456789ABCDE');
        fps.add(fp);
        String reportMetadataJSON = MobileReportController.getReportMetadata(reportId, fps);
        Map<String,Object> reportMap = (Map<String, Object>) JSON.deserializeUntyped(reportMetadataJSON);
        Map<String,Object> reportMetadata = (Map<String, Object>) reportMap.get('reportMetadata');
        List<Object> reportFilters = (List<Object>) reportMetadata.get('reportFilters');
        Map<String,Object> firstFilter = (Map<String,Object>) reportFilters.get(0);
        System.assertEquals('0123456789ABCDE', firstFilter.get('value'));
    }
    
    @isTest static void testGetReportMetadataError() {
        String reportId = '';
        String reportMetadataJSON = MobileReportController.getReportMetadata(reportId, new List<MobileReportController.FilterParam>());
        System.assert(reportMetadataJSON.contains('No report ID was provided. Please provide a report ID in the query parameters.'));
    }
}