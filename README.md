# 🧠 Crisen – Détection et Suivi des Crises Épileptiques

**Crisen** est une application iOS/watchOS conçue pour détecter, surveiller et enregistrer les crises épileptiques via l’Apple Watch. Elle facilite le suivi des événements et fournit un historique exploitable à des fins médicales ou personnelles.

---

## 🎯 Objectifs

- ✅ Détection en temps réel des crises via Apple Watch
- ✅ Transmission des alertes et données à l’iPhone connecté
- ✅ Historisation des événements (timestamp, intensité)
- ✅ Affichage des données dans l’app iOS
- ✅ Intégration future vers un suivi médical ou une exportation

---

## 🛠 Fonctionnement

### 📲 iPhone (iOS)
- Affiche la connexion avec l’Apple Watch
- Reçoit des messages de détection de crise envoyés depuis la montre
- Stocke les événements dans un historique via `HistoryManager`
- Affiche les états :
  - `watchConnected` → montre connectée
  - `isSeizureOngoing` → crise en cours
  - `isMonitoringOnWatch` → surveillance active

### ⌚ Apple Watch (watchOS)
- Surveille les signes de crise (ex: mouvements anormaux, capteurs)
- Envoie un message à l’iPhone via `WCSession` contenant :
  - `seizure: true`
  - `timestamp`
  - `intensity`
  - `monitoring` flag

---

## 🔄 Architecture

- `ConnectivityManager`  
  Gère la communication avec la montre (`WCSessionDelegate`) et publie les états via `@Published` pour l'interface SwiftUI.

- `HistoryManager`  
  Permet d’ajouter et consulter des événements liés aux crises détectées.

- `SeizureEvent`  
  Modèle de données pour chaque crise détectée : `id`, `timestamp`, `intensity`.

---

## 🚀 Démarrage rapide

### Pré-requis

- macOS avec **Xcode 15+**
- Compte Apple Developer (pour app watchOS)
- Apple Watch connectée (pour tests réels)

### Installation

1. Clone le projet :

   ```bash
   git clone https://github.com/neokura/crisen.git
   cd crisen
