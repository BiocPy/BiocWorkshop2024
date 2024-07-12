## Bioc 2024 workshop tutorial

This is a reproducible Quarto book with reusable snippets. If you're new to Quarto books, you can explore more about them [here](https://quarto.org/docs/books). 

## Setting Up the Tutorial Locally

To get started locally, follow these steps:

- Install [quarto-cli](https://quarto.org/docs/get-started/).
- Install the necessary packages listed in [requirements.txt](./requirements.txt) and [rpackages.R](rpackages.R).

```shell
pip install -r requirements.txt
Rscript rpackages.R
```

- Run quarto preview to view the HTML version of the site.

```shell
qurto preview
```

Take advantage of GitHub actions, which are available to automatically publish the tutorial book whenever changes are made on the **master** branch.