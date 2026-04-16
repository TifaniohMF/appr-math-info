#  Note important quand tu fait du machine learning

## Les étapes d'algorithmes en pratique

1. Collecter les données (X, y) : réunir les observations avec la variable explicative x et la variable cible y

2. Séparer le Train / Test : garder une partie des données pour évaluer le modèle sur des données jamais vues

3. Calculer des coefficients : $\beta_{0}$ et $\beta_{1}$ sur le jeu Train à l'aide des formules des moindres carrés

4. Prédire : $\hat{y} = \beta_{0}+ \beta_{1}x$ sur le jeu Test  appliquer le modèle aux données non vues

5. Évaluer : la qualité du modèle avec les métriques : MSE (erreur quadratique moyenne) et R2(coefficient de détermination)

6. Interpreter : analyser les coecients ($\beta_{1}$ = effet de x sur y) et vérier la cohérence du modèle