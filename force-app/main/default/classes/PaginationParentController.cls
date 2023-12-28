public class PaginationParentController {
    public Map<String, Schema.SObjectType> getGlobelDescribe;
    Map<String, Schema.SObjectField> MapofField;
    public list<SelectOption> allObjectList{get;set;}
    public String selectedObject{get;set;}
    public list<SelectOption> allFieldsList{get;set;}
    public list<String> initialSelectFieldForAdd{get;set;}
    
    public list<SelectOption> selectedFieldList{get;set;}
    public list<String> initialSelectFieldForRemove{get;set;}
    
    
    public PaginationParentController(){
        getGlobelDescribe = new Map<String, Schema.SObjectType>();
        allObjectList = new list<SelectOption>();
        allFieldsList = new list<SelectOption>();
        selectedFieldList = new list<SelectOption>();
        
        getAllObjects();
    }
    public void getAllObjects(){
        getGlobelDescribe = Schema.getGlobalDescribe();
        
        allObjectList.add(new SelectOption('None','None',false));
        for(String obj : System.Label.Standard_Object.split(',')){
            if(Schema.getGlobalDescribe().get(obj).getDescribe().isQueryable()){
             	allObjectList.add(new SelectOption(getGlobelDescribe.get(obj).getDescribe().getName(),getGlobelDescribe.get(obj).getDescribe().getLabel()));   
            }
        }
        for(Schema.SObjectType obj : getGlobelDescribe.Values()){
            if(obj.getDescribe().isCustom()){
             	allObjectList.add(new SelectOption(obj.getDescribe().getName(),obj.getDescribe().getLabel()));   
            }
        }
    }
    public void getFields(){
        if(selectedObject != 'None'){
            reset();
            MapofField = getGlobelDescribe.get(selectedObject).getDescribe().fields.getMap();
            allFieldsList.clear();
            for(Schema.SObjectField fields : MapofField.values()){
                if(fields.getDescribe().isAccessible() && fields.getDescribe().isFilterable() && fields.getDescribe().isSortable()){
                    allFieldsList.add(new SelectOption(fields.getDescribe().getName(),fields.getDescribe().getlabel()));
                }            
            }
            allFieldsList.sort();
        }
        else{
            reset();
        }
    }
    public void addFields(){
        for(String fields : initialSelectFieldForAdd){
            selectedFieldList.add(new SelectOption(MapofField.get(fields).getDescribe().getName(),MapofField.get(fields).getDescribe().getlabel()));       
        }
        for(SelectOption sl : selectedFieldList){
            if(allFieldsList.contains(sl)){
                allFieldsList.remove(allFieldsList.indexOf(sl));
            }
        }   
        allFieldsList.sort();
        selectedFieldList.sort();
    }
    public void removeFields(){
        for(String fields : initialSelectFieldForRemove){
            allFieldsList.add(new SelectOption(MapofField.get(fields).getDescribe().getName(),MapofField.get(fields).getDescribe().getlabel()));       
        }
        for(SelectOption sl : allFieldsList){
            if(selectedFieldList.contains(sl)){
            	selectedFieldList.remove(selectedFieldList.indexOf(sl));
            }
        }   
        allFieldsList.sort();
        selectedFieldList.sort();
    }
    public void reset(){
        if(allFieldsList != null){
            allFieldsList.clear();
        }
        if(selectedFieldList != null){
            selectedFieldList.clear();
        }
    }
    public void resetAll(){
        selectedObject = 'Zone';
        reset();
    }
}