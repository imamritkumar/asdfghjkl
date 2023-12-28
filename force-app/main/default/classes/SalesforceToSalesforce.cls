@RestResource(urlMapping='/FileUpload/*')
global with sharing class SalesforceToSalesforce {
    @HttpPost
    global static void getFiles(){
        System.debug('call');
        RestRequest res = RestContext.request;
        RestResponse Response = new RestResponse();
        Response.statusCode =400;
        Response.responseBody =Blob.valueOf(JSON.serialize('Error while adding lead data')); 
        System.debug('res.requestBody :- '+string.valueOf(res.requestBody));
        System.debug('Response.statusCode :- '+Response.statusCode);
        System.debug('Response.responseBody :- '+Response.responseBody);
    }
}





// @RestResource(urlMapping='/RahejaVistasEliteApi/*')
// global with sharing class RahejaVistasElite_EnquiryApi {

//     @HttpPost   
//    global static void upsertEnquiry(){
     
       
//         List <PropStrength__Request__c> listToInsert = new List <PropStrength__Request__c> ();
      
       
//        RestRequest request = RestContext.request;
//        RestResponse res = RestContext.response;
//         Blob body = request.requestBody;
//         String requestString = body.toString();
        
        
//         System.debug('----------------'+requestString);
//         System.debug(request.resourcePath);
//         System.debug(request.requestURI);
//         System.debug(request.params);
//         System.debug(request.headers);
        
//          List<EnquiryWrapperForRahejaVistasElite> listOfWrapperReq = new List<EnquiryWrapperForRahejaVistasElite>();
//         if(requestString != ''){
//             listOfWrapperReq = (List<EnquiryWrapperForRahejaVistasElite>)JSON.deserialize(requestString , List<EnquiryWrapperForRahejaVistasElite>.class);
//         }
       
//        RestContext.response.addHeader('Content-Type', 'application/json');
       	
       
       
//         String Name = listOfWrapperReq[0].Name != null ? listOfWrapperReq[0].Name: '' ;
//         String Email = listOfWrapperReq[0].Email!= null ? listOfWrapperReq[0].Email: '' ;
//         String Mobile = listOfWrapperReq[0].Mobile != null ? listOfWrapperReq[0].Mobile: '' ;
//         String City = listOfWrapperReq[0].City != null ? listOfWrapperReq[0].City: '' ;
//         String EnquirySourcePrimary = listOfWrapperReq[0].EnquirySourcePrimary != null ? listOfWrapperReq[0].EnquirySourcePrimary: '' ;
//         String EnquiryStatus = listOfWrapperReq[0].EnquiryStatus != null ? listOfWrapperReq[0].EnquiryStatus: '' ;
//         String BudgetRange = listOfWrapperReq[0].BudgetRange != null ? listOfWrapperReq[0].BudgetRange: '' ;
//        String CurrentResidenceType = listOfWrapperReq[0].CurrentResidenceType != null ? listOfWrapperReq[0].CurrentResidenceType: '' ;
//        String WorkType = listOfWrapperReq[0].WorkType != null ? listOfWrapperReq[0].WorkType: '' ;
//        String WorkCompany = listOfWrapperReq[0].WorkCompany != null ? listOfWrapperReq[0].WorkCompany: '' ;
//        String Designation = listOfWrapperReq[0].Designation != null ? listOfWrapperReq[0].Designation: '' ;
//        String IndustryType = listOfWrapperReq[0].IndustryType != null ? listOfWrapperReq[0].IndustryType: '' ;
//        String WorkLocation = listOfWrapperReq[0].WorkLocation != null ? listOfWrapperReq[0].WorkLocation: '' ;
//        String AgeGroup = listOfWrapperReq[0].AgeGroup != null ? listOfWrapperReq[0].AgeGroup: '' ;
//        String SourceOfFund = listOfWrapperReq[0].SourceOfFund != null ? listOfWrapperReq[0].SourceOfFund: '' ;
//        String PurposeOfPurchase = listOfWrapperReq[0].PurposeOfPurchase != null ? listOfWrapperReq[0].PurposeOfPurchase: '' ;
//        String Mailingcity = listOfWrapperReq[0].Mailingcity != null ? listOfWrapperReq[0].Mailingcity: '' ;
//        String MailingState = listOfWrapperReq[0].MailingState != null ? listOfWrapperReq[0].MailingState: '' ;
//        String Mailingcountry = listOfWrapperReq[0].Mailingcountry != null ? listOfWrapperReq[0].Mailingcountry: '' ;
//        String Mailingpostal = listOfWrapperReq[0].Mailingpostal != null ? listOfWrapperReq[0].Mailingpostal: '' ;
//        String MailingStreet = listOfWrapperReq[0].MailingStreet != null ? listOfWrapperReq[0].MailingStreet: '' ;
//        String Ethnicity = listOfWrapperReq[0].Ethnicity != null ? listOfWrapperReq[0].Ethnicity: '' ;
//        String ConfigurationInterested = listOfWrapperReq[0].ConfigurationInterested != null ? listOfWrapperReq[0].ConfigurationInterested: '' ;
//        String SiteVisitRating = listOfWrapperReq[0].SiteVisitRating != null ? listOfWrapperReq[0].SiteVisitRating: '' ;
//        String CurrentResidenceOwnership = listOfWrapperReq[0].CurrentResidenceOwnership != null ? listOfWrapperReq[0].CurrentResidenceOwnership: '' ;
//        String ReasonForLost = listOfWrapperReq[0].ReasonForLost != null ? listOfWrapperReq[0].ReasonForLost: '' ;
//        String OldCallComment = listOfWrapperReq[0].OldCallComment != null ? listOfWrapperReq[0].OldCallComment: '' ;
//        String EnquirySourceSecondary = listOfWrapperReq[0].EnquirySourceSecondary != null ? listOfWrapperReq[0].EnquirySourceSecondary: '' ;
//        String DateOfWalkin = listOfWrapperReq[0].DateOfWalkin != null ? listOfWrapperReq[0].DateOfWalkin: 'null' ;
       
       
     
//        List<PropStrength__Projects__c> projname =[select id from PropStrength__Projects__c where Name ='Raheja Vistas Tower D Tower E Tower F'];
        
// 		PropStrength__Request__c Enq = new PropStrength__Request__c();

//        if(Mobile != null && String.isNotBlank(Mobile)) { 
//            List<Contact> conRec = [SELECT id, name,MailingAddress,Email, MobilePhone FROM Contact WHERE MobilePhone =:Mobile];
           
//             if(conRec.size() > 0) {  
//                 Enq.PropStrength__Primary_Contact__c = conRec[0].Id;
//             }
           
//            else {                   
//                 Contact con = new Contact();
//                 con.FirstName = Name.substringBefore(' '); 
//                 con.LastName = Name.substringAfter(' ');
//                 con.MobilePhone = Mobile; 
//                 con.Email = Email;
//                 con.MailingCity=Mailingcity;
//                 con.MailingState=MailingState;
//                 con.MailingCountry=Mailingcountry;
//                 con.MailingPostalCode=Mailingpostal;
//                 con.MailingStreet=MailingStreet;
//                 insert con;
//                 Enq.PropStrength__Primary_Contact__c = con.Id;
//             }
           
//        }
       
//        Enq.Budget_Range__c = BudgetRange;
//        Enq.City__c = City;
//        Enq.PropStrength__Request_Status__c = EnquiryStatus;
//        Enq.Enquiry_Source_Primary__c=EnquirySourcePrimary;
       
//        Enq.Current_Residence_Type__c = CurrentResidenceType;
//        Enq.Work_Type__c = WorkType;
//        Enq.Work_Company__c = WorkCompany;
//        Enq.Designation__c = Designation;
//        Enq.Industry_Type__c = IndustryType;
//        Enq.Work_Location__c = WorkLocation;
//        Enq.Age_Group__c=AgeGroup;
//        Enq.Source_of_Fund__c=SourceOfFund;
//        Enq.Purpose_of_Purchase__c=PurposeOfPurchase;
//        Enq.Ethnicity__c=Ethnicity;
//        Enq.Configuration_Interested_In__c=ConfigurationInterested;
//        Enq.Site_Visit_Rating__c=SiteVisitRating;
//        Enq.Current_Residence_Ownership__c=CurrentResidenceOwnership;
//        Enq.Reason_for_Lost__c=ReasonForLost;
//        Enq.Old_Call_Comments__c = OldCallComment;
//        Enq.Enquiry_Source_Secondary__c=EnquirySourceSecondary;       
//        Enq.Date_of_Walk_In__c= (DateOfWalkin!= null && DateOfWalkin!= '') ? Date.valueOf(DateOfWalkin) : null;
       
//        if(projname.size()>0){
//        Enq.PropStrength__Project__c = projname[0].Id ;
//        }
       
//         listToInsert.add(Enq);
//         System.debug('listToInsert===> ' + listToInsert);
//         for (Database.SaveResult sr: Database.insert(listToInsert, false)) {
//             String errorMsg = '';
//             if (sr.isSuccess()) {
//                 System.debug('success');
//                 res.statusCode = 200;
//                 res.responseBody = Blob.valueOf(JSON.serialize(new ValidateResponse('Successfully Inserted', 'Lead data successfully generated', sr.Id,listToInsert[0].PropStrength__Primary_Contact__c))); 
//             } else {
//                 for (Database.Error err: sr.getErrors()) {
//                     errorMsg = err.getStatusCode() + ': ' + err.getMessage();
//                 }
//                 res.statusCode = 400;
//                 res.responseBody = Blob.valueOf(JSON.serialize(new errorResponse('Fail', 'Error while adding lead data'))); 
//             }
//             System.debug('errorMsg===> ' + errorMsg);
//         } 
     
//    }
    
//      public class ValidateResponse {
//         public String status;
//         public String message;
//         public String Enq_Id;
//         public String Contact_Id;
//         public ValidateResponse( string status, String message, String customer_name, String conId) {
//             this.status = status;
//             this.message = message;
//             this.Enq_Id = customer_name;
//             this.Contact_Id = conId;
//         }
        
//     }
    
    
//     public class ValidateConResponse {
//         public String status;
//         public String message;
//         public String Customer_Name;
        
//         public ValidateConResponse( string status, String message, String customer_name) {
//             this.status = status;
//             this.message = message;
//             this.Customer_Name = customer_name;           
//         }
        
//     }
    
//     public class errorResponse {
//         public String status;
//         public String message;
        
//         public errorResponse( string status, String message) {
//             this.status = status;
//             this.message = message;
            
//         }
//     }
// }