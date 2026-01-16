# Composable probabilistic models can lower barriers to rigorous infectious disease modelling

[![Render and Deploy Quarto Paper](https://github.com/EpiAware/ComposableProbabilisticIDModels/actions/workflows/render-and-deploy.yml/badge.svg?branch=main)](https://github.com/EpiAware/ComposableProbabilisticIDModels/actions/workflows/render-and-deploy.yml)
[![Citation](https://img.shields.io/badge/Cite-CFF-blue)](https://github.com/EpiAware/ComposableProbabilisticIDModels/blob/main/CITATION.cff)

![Visual abstract showing the problem (current approaches require trade-offs between timely, collaborative, and rigorous modelling), our solution (a composable domain-specific language built on a probabilistic backend), and the impact (enabling collaboration, rapid response, adaptability to new threats, and rigorous evidence for decision making).](figures/visual-abstract.png)

## Abstract

Recent outbreaks of Ebola, COVID-19 and mpox, alongside routine surveillance of endemic pathogens, have demonstrated the value of modelling for synthesising data to inform decision making. For modelling evidence to effectively inform policy it must be timely, rigorous, and collaborative, yet current approaches struggle to be all three. Methods broadly fall into approaches that chain separate models together, offering flexibility but losing information and introducing bias, or approaches that rigorously analyse all data together but cannot be separated into reusable parts. Composable models, where components can be reused across contexts, can be both rigorous and flexible, enabling rapid collaborative model development. We outline proposed requirements for a composable infectious disease modelling framework and present a proof of concept domain-specific language built on the Turing.jl probabilistic programming language in Julia with an R interface. We demonstrate our approach conceptually using models from published epidemiological analyses, and in practice through a worked autoregressive example. We replicate three published analyses, composing elements of our autoregressive example with shared and novel components: a COVID-19 analysis for South Korea using a renewal process, adding components for reporting delays and day-of-week effects to replicate EpiNow2 for real-time nowcasting, and an ordinary differential equation analysis of influenza outbreak data. We then discuss strengths, limitations, and alternative approaches. We find that our proof of concept can address the tension between rigour and flexibility, though work remains to realise this potential. Our approach enables interdisciplinary collaboration by lowering technical barriers for domain experts to contribute specialised components, supporting both routine surveillance and outbreak response. For multi-model efforts, common components enable attribution of differences to assumptions rather than implementation. Our approach is also well suited for large language model assisted model construction. Given the unpredictable nature of future infectious disease threats, investment in adaptable modelling infrastructure is critical.

💻 **[Source Code](https://github.com/EpiAware/ComposableProbabilisticIDModels)** (GitHub)

📖 **[Read the paper](https://epiaware.org/ComposableProbabilisticIDModels/paper.pdf)** (PDF)

🌐 **[Read the paper](https://epiaware.org/ComposableProbabilisticIDModels/paper.html)** (HTML)

📑 **[Supplementary Information: Case Studies](https://epiaware.org/ComposableProbabilisticIDModels/case-studies.html)** (HTML)

📦 **[EpiAware.jl Documentation](https://cdcgov.github.io/Rt-without-renewal/dev/)** | 💻 [Code](https://github.com/seabbs/Rt-without-renewal/tree/76fcd1297b4f978662726f9f33fb327ffe3be374)

📦 **[EpiAwareR Documentation](https://epiaware.org/ComposableProbabilisticIDModels/epiawarer/)** | 💻 [Code](https://github.com/sbfnk/EpiAwareR/tree/2302c7fffc72a9a8eabb36516fbf5abfb89cffd7)

## Citation

*Paper citation information will be added upon publication.*

If reusing the code, please cite using DOI: [10.5281/zenodo.17884675](https://doi.org/10.5281/zenodo.17884675). See [CITATION.cff](CITATION.cff) for full citation information.

## Running the analysis

### Prerequisites

1. **Quarto**: Follow the instructions at [quarto.org](https://quarto.org/docs/get-started/) to install Quarto.

2. **Julia**: Follow the instructions at [juliaup](https://github.com/JuliaLang/juliaup) to install Julia using the official Julia version manager.

3. **R** (optional, for EpiAwareR): Install [R](https://cran.r-project.org/) (version 4.0.0 or higher) if you want to run the EpiAwareR vignettes.

4. **Task** (optional): Install [Task](https://taskfile.dev/installation/) for automated workflow management.

### Using Task (Recommended)

```bash
task
```

This automatically handles git submodules, Julia environment setup, Quarto extension installation, and document rendering.

Available tasks:

- `task` - Render all documents (default)
- `task render-case-studies` - Render case studies (generates figures)
- `task render-index` - Render main document
- `task preview` - Preview document with live reload
- `task repl` - Launch Julia REPL with project environment
- `task install-extensions` - Install Quarto extensions
- `task renv-restore` - Restore R environment from renv.lock
- `task setup-epiawarer` - Set up EpiAwareR with Julia backend
- `task --list` - Show all available tasks

### Using Docker

A pre-built Docker image with all dependencies (Julia, Quarto, packages) is available from GitHub Container Registry.

```bash
# Pull and tag with a shorter name
docker pull ghcr.io/epiaware/composableprobabilisticidmodels:latest
docker tag ghcr.io/epiaware/composableprobabilisticidmodels:latest composableidmodels

# Run task commands with your local project mounted
docker run --rm -v $(pwd):/project composableidmodels default

# List available tasks
docker run --rm -v $(pwd):/project composableidmodels --list
```


### Manual Execution

1. Install Julia 1.11.6 (we expect any version of 1.11 to work well):
   ```bash
   juliaup add 1.11.6
   juliaup override set 1.11.6
   ```

2. Initialise git submodules:
   ```bash
   git submodule update --init --recursive
   ```

3. Set up Julia environment:
   ```bash
   julia +1.11.6
   ```

   Then in the Julia REPL:
   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   ```

4. Render the document:
   ```bash
   quarto render
   ```

### Running interactively

#### Case Studies (Julia)

The case studies in `case-studies.qmd` can be run interactively using Quarto's preview mode:

1. Set up the environment:
   ```bash
   task instantiate
   ```

2. Preview with live reload:
   ```bash
   task preview
   ```

   Or open `case-studies.qmd` directly in VS Code or another editor with Quarto support.

#### EpiAwareR vignettes (R)

The `EpiAwareR/` submodule contains R vignettes demonstrating the R interface to EpiAware:

- `EpiAwareR.Rmd` - Getting started guide
- `mishra-case-study.Rmd` - Replicating Mishra et al. (2020) COVID-19 analysis
- `epinow2-comparison.Rmd` - Comparison with EpiNow2 workflows

To run the vignettes interactively:

1. Set up EpiAwareR with Julia backend:
   ```bash
   task setup-epiawarer
   ```

2. Open the vignettes in RStudio or VS Code:
   ```
   EpiAwareR/vignettes/EpiAwareR.Rmd
   EpiAwareR/vignettes/mishra-case-study.Rmd
   EpiAwareR/vignettes/epinow2-comparison.Rmd
   ```

4. Run code chunks interactively using your IDE's execution features.

## Funding

We acknowledge financial support from CDC Grant NU38FT00008 (K.J., S.A, S.F.).
This project was made possible by cooperative agreement CDC-RFA-FT-23-0069 from the CDC's Center for Forecasting and Outbreak Analytics.
Its contents are solely the responsibility of the authors and do not necessarily represent the official views of the Centers for Disease Control and Prevention.
We also acknowledge financial support from Wellcome 210758/Z/18/Z (S.F.).
