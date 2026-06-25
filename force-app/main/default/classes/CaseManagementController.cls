public with sharing class CaseManagementController {
    public static void createCase(Case newCase) {
        insert newCase;
    }
    
    public static void updateCase(Case updatedCase) {
        update updatedCase;
    }
    
    public static List<Case> getCases() {
        return [SELECT Id, Subject, Description, AccountId FROM Case];
    }
}