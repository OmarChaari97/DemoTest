@isTest
public with sharing class CloseCasesBatchTest {
    @testSetup
    static void setup() {
        // Créer des cases pour les tests
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 10; i++) {
            cases.add(new Case(
                Subject = 'Test Case ' + i,
                Status = 'Nouveau'
            ));
        }
        insert cases;
    }

    @isTest
    static void testCloseCases() {
        Test.startTest();
        // Exécuter le batch
        CloseCasesBatch batch = new CloseCasesBatch();
        batch.execute(null);
        Test.stopTest();

        // Vérifier que les cases sont fermées
        List<Case> closedCases = [SELECT Id, Status FROM Case WHERE Status = 'Fermé'];
        System.assertEquals(10, closedCases.size());
    }
}