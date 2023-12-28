public with sharing class ListViewController {

    /**This is the list which will be passed to Visualforce Page and in turn passed to Flow from Visualforce**/
    public List < Case > LstSelectedCases {
        get;
        set;
    }
    
    public ListViewController(ApexPages.StandardSetController listcontroller) {
      
        Set < Id > casesSelectedIds = new set < Id > ();
        LstSelectedCases = new List <case >();
            
        for (Case c: (Case[]) listcontroller.getSelected()) {
            casesSelectedIds.add(c.id);
        }
        
        /**Querying on the Selected records and fetching fields which are required in Flow **/
        LstSelectedCases = [select Id,Subject from case where id in: casesSelectedIds];
    }
}