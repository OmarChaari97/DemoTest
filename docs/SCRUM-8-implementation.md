# Implémentation — SCRUM-8

## 🏗️ Choix techniques
Pour répondre aux besoins de l'entreprise, nous allons utiliser le pattern de rapport Salesforce standard avec filtrage et tri. Ce choix est motivé par la simplicité de la requête et la disponibilité des fonctionnalités de rapportage dans Salesforce. Nous n'aurons pas besoin de créer des classes Apex personnalisées pour cette tâche, car les fonctionnalités de rapportage standard de Salesforce sont suffisantes pour répondre aux exigences.

## 💻 Implémentation

### Classe principale
Il n'y a pas de classe principale à implémenter en Apex pour cette spécification, car nous utilisons les fonctionnalités de rapportage standard de Salesforce.

### Classe de test
Il n'y a pas non plus de classe de test à écrire en Apex pour cette spécification, car les tests seront effectués manuellement via l'interface utilisateur de Salesforce pour vérifier que le rapport fonctionne comme attendu.

### Script d'exécution anonyme
Il n'y a pas de script d'exécution anonyme à écrire pour cette spécification, car nous n'avons pas besoin d'exécuter du code Apex pour créer ou exécuter le rapport.

## 🚀 Instructions de déploiement
1. Créer un nouveau rapport dans Salesforce en allant sur l'onglet "Rapports" et en cliquant sur "Nouveau rapport".
2. Sélectionner "Compte" comme objet principal pour le rapport.
3. Ajouter les champs suivants au rapport : Nom, Revenu annuel, Industrie, Type.
4. Appliquer un filtre pour afficher uniquement les comptes avec un revenu annuel supérieur à 100 000.
5. Trier le rapport par ordre décroissant du revenu annuel.
6. Enregistrer et exécuter le rapport pour vérifier les résultats.
7. Partager le rapport avec les utilisateurs appropriés ou configurer les permissions pour qu'ils puissent y accéder.

## ⚠️ Points d'attention
- Assurez-vous que les champs utilisés dans le rapport sont correctement configurés et remplis dans les enregistrements de Compte.
- Gérez les cas où le champ "Revenu annuel" est vide ou n'est pas numérique en appliquant des règles de validation ou en les excluant du rapport.
- Comprenez comment gérer les devises si les revenus sont enregistrés dans différentes devises, en utilisant les fonctionnalités de gestion des devises de Salesforce si nécessaire.