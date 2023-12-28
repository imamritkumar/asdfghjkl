public with sharing class MyBatchClass {
    @InvocableMethod(label='Mail1' description='call this method from apex')
    public Static void execute() {
        String emailTemplate;
        String table;
        String finalMessage;
        list<String> emailId = new list<String>();
        list<Contact> conlist = new list<Contact>();
        Map<String, List<Contact>> expireDate = new Map<String, List<Contact>>();
        String query = 'SELECT Id, Name, field_1__c, field_2__c, field_3__c, field_4__c, Email FROM Contact WHERE field_1__c != null AND field_2__c != null AND field_3__c!= null AND field_4__c != null AND AccountId != null ORDER BY Name';
        conlist = Database.Query(query);
        date temp1;
        date temp2;
        date temp3;
        date temp4;
        boolean field1;
        boolean field2;
        boolean field3;
        boolean field4;
        for(Contact con : conlist) {
            System.debug('rec'+con);
            temp1 = null;
            field1 = false;
            temp1 = con.field_1__c + 30;
            field1 = (temp1 <= System.today());
            if(field1){
                if(!expireDate.containsKey('Field 1')){
                    expireDate.put('Field 1', new List<Contact>());
                }
                expireDate.get('Field 1').add(con);
            }
            
			temp2 = null;
            field2 = false; 
            temp2 = con.field_2__c + 30;
            field2 = (temp2 <= System.today());
            if(field2){
                if(!expireDate.containsKey('Field 2')){
                    expireDate.put('Field 2', new List<Contact>());
                }
                expireDate.get('Field 2').add(con);
            }
			
            temp3 = null;
            field3 = false;
            temp3 = con.field_3__c + 30;
            field3 = (temp3 <= System.today());
            if(field3){
                if(!expireDate.containsKey('Field 3')){
                    expireDate.put('Field 3', new List<Contact>());
                }
                expireDate.get('Field 3').add(con);
            }
			
            temp4 = null;
            field4 = false;
            temp4 = con.field_4__c + 30;
            field4 = (temp4 <= System.today());
            if(field4){
                if(!expireDate.containsKey('Field 4')){
                    expireDate.put('Field 4', new List<Contact>());
                }
                expireDate.get('Field 4').add(con);
            }            
        }
        EmailTemplate et = [select id, htmlvalue, body, name from emailtemplate where name = 'email'];
        emailTemplate = et.htmlvalue;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		table='';
        for(String Con : expireDate.keySet()){
            System.debug('Contact :-'+Con);
            System.debug('record:-'+expireDate.get(Con));
            list<Contact> conRecord = expireDate.get(Con);
            table +='<table border="1">'+
                            + '<tr><th>'+Con+'</th><th>Email</th></tr>';
            for(Contact rec : conRecord){
                emailId.add(rec.Email);
                table +='<tr><td>'+rec.Name+'</td><td>'+rec.Email+'</td></tr>';
            }
            table+='</table><br>';
        }
        System.debug('String:-'+table);
		finalMessage = emailTemplate.substring(0, emailTemplate.indexOf('Thanks')) + table + emailTemplate.substring(emailTemplate.indexOf('Thanks'), emailTemplate.length());
        mail.setToAddresses(emailId);
        mail.setSubject('test');
        mail.setHtmlBody(finalMessage); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }   
}