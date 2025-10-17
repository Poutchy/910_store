# 910_store

## Membres du binôme

- MAUTI Enzo
- MAURY Corentin

## Description de l’application

**910_store** est une application web développée avec Ruby on Rails permettant de gérer une boutique en ligne :
- Authentification des utilisateurs
- Page principal avec la liste des produits
- Visualisation détaillé d'un produit
- Ajout, modification et suppression de produits (pour les utilisateurs authentifiés)  
- Gestion des stocks

## Prérequis

- Ruby (version recommandée : 3.4.1)
- Rails (version recommandée : 8.0.3)
- MySQL
- Docker (pour le déploiement Kubernetes)
- kubectl et un cluster Kubernetes

## Installation et utilisation locale

1. **Cloner le dépôt**
   ```sh
   git clone https://github.com/Poutchy/910_store.git
   cd 910_store
   ```

2. **Installer les dépendances**
   ```sh
   bundle install
   ```

3. **Configurer la base de données**
   ```sh
   rails db:create db:migrate db:seed
   ```

4. **Lancer le serveur**
   ```sh
   rails server
   ```
   Accède à l’application sur [http://localhost:3000](http://localhost:3000).

## Déploiement sur un cluster Kubernetes (TODO)

1. **Construire l’image Docker**
   ```sh
   docker build -t <dockerhub-username>/910_store:latest .
   docker push <dockerhub-username>/910_store:latest
   ```

2. **Créer les fichiers de configuration Kubernetes**
   - `deployment.yaml` pour le déploiement de l’application
   - `service.yaml` pour exposer l’application
   - (optionnel) `postgres.yaml` pour la base de données

3. **Déployer sur le cluster**
   ```sh
   kubectl apply -f postgres.yaml      # si besoin
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   ```

4. **Accéder à l’application**
   - Utilise `kubectl get svc` pour récupérer l’URL ou l’IP d’accès.
