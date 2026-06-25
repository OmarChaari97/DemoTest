@isTest
public class CaseManagementPermissionSetTest {
    @isTest
    static void testCreateCaseWithPermission() {
        Test.startTest();
        // Attribution de la permission set à l'utilisateur de test
        User testUser = [SELECT Id FROM User WHERE Username = 'testuser@example.com'].get(0);
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Label = 'Case Management Permission Set'].get(0);
        PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = ps.Id, AssigneeId = testUser.Id);
        insert psa;
        
        // Création d'un nouveau Case avec l'utilisateur ayant la permission
        Case newCase = new Case(Subject = 'Test Case', Description = 'Description de test', AccountId = '001d300000000abc');
        Test.setMock(UserInfo.class, new MockUserInfo(testUser.Id));
        CaseManagementController.createCase(newCase);
        
        // Vérification que le Case a été créé avec succès
        System.assertEquals(1, [SELECT COUNT() FROM Case WHERE Id = :newCase.Id]);
        Test.stopTest();
    }
    
    @isTest
    static void testUpdateCaseWithPermission() {
        Test.startTest();
        // Attribution de la permission set à l'utilisateur de test
        User testUser = [SELECT Id FROM User WHERE Username = 'testuser@example.com'].get(0);
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Label = 'Case Management Permission Set'].get(0);
        PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = ps.Id, AssigneeId = testUser.Id);
        insert psa;
        
        // Création d'un nouveau Case
        Case existingCase = new Case(Subject = 'Existing Case', Description = 'Existing description', AccountId = '001d300000000abc');
        insert existingCase;
        
        // Mise à jour du Case avec l'utilisateur ayant la permission
        existingCase.Subject = 'Updated Subject';
        Test.setMock(UserInfo.class, new MockUserInfo(testUser.Id));
        CaseManagementController.updateCase(existingCase);
        
        // Vérification que le Case a été mis à jour avec succès
        System.assertEquals('Updated Subject', [SELECT Subject FROM Case WHERE Id = :existingCase.Id].get(0).Subject);
        Test.stopTest();
    }
}