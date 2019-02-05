# MobileReport

Visualforce Page used to display standard report results using dynamic filters in the Salesforce Mobile App.

## Usage

To use, provide an id of a report and any number of fv# parameters in the URL query string

For example, /apex/MobileReport?id=123456&fv0=ABC&fv2=123 will display the report with the
ID "123456" and modify the first report filter value to "ABC" and the third report filter value
to 123.

NOTE: This page is designed specifically for the Salesforce Mobile App. 
Some features may not be functional outside of the Salesforce Mobile App.