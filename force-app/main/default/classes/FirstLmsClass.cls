public class FirstLmsClass {
    public static Map<String,String> objectMap = new Map<String,String>();
    @AuraEnabled
    public static Map<String,String> getObjects(){
        list<String> ObjList = System.Label.Standard_Object.split(',');
        try {
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
                String name = objTyp.getDescribe().getName();
                String label = objTyp.getDescribe().getLabel();
                if(ObjList.contains(label.uncapitalize()) ||  objTyp.getDescribe().isCustom()){      
                    objectMap.put(name,label);
                }
            }
            if(objectMap != null && objectMap.size() > 0){
                return objectMap;   
            }else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static list<wrapper> getFields(String obj){
        list<wrapper> fieldMap = new list<wrapper>();
        Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe();
        Schema.SObjectType fld = gd.get(obj);
        Schema.DescribeSObjectResult r = fld.getDescribe();
        Map<String, Schema.SObjectField> MapofField = r.fields.getMap();
        for(String field : MapofField.keySet()){
            Schema.DescribeFieldResult F = MapofField.get(field).getDescribe();
            if(F.isAccessible() && F.isFilterable()){
                fieldMap.add(new wrapper(F.getLabel(), F.getName(), String.valueOf(F.getType()).toLowerCase(), F.isSortable()));
            }
        }
        return fieldMap;
    }
    @AuraEnabled
    public static list<SObject> getData(String query){
        try {
            return Database.query(query);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    public class wrapper{
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        @AuraEnabled public String type;
        @AuraEnabled public Boolean Sortable;
        public wrapper(String label, String value, String type, Boolean Sortable){
            this.label = label;
            this.value = value;
            this.type  = type;
            this.Sortable  = Sortable;
        }
    }
}