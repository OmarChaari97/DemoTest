@isTest
public with sharing class UpdateAnnualRevenueBatchTest {
    @isTest
    public static void testUpdateAnnualRevenue() {
        Test.startTest();
        // Créer un compte avec un revenu annuel nul
        Account account = new Account(Name = 'Test Account', AnnualRevenue = 0);
        insert account;
        
        // Exécuter le batch
        UpdateAnnualRevenueBatch batch = new UpdateAnnualRevenueBatch();
        Database.executeBatch(batch);
        
        // Vérifier que le revenu annuel a été mis à jour
        account = [SELECT AnnualRevenue FROM Account WHERE Id = :account.Id];
        System.assertEquals(150000, account.AnnualRevenue);
        
        Test.stopTest();
    }
}