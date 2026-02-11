# 40-minute presentation

A 40-minute talk covering the full paper "Composable probabilistic models can lower barriers to rigorous infectious disease modelling".

## Planned timings

| Section | Duration | Slides |
|---|---|---|
| Talk plan + TL;DR | ~1 min | Talk plan, TL;DR |
| Background | ~14 min | The gap, ONS example, joint models, Rt ecosystem, Rt estimation research, Bayesian workflow, composability |
| Proposed requirements | ~5 min | Requirements for a composable framework |
| Proof of concept | ~10 min | EpiAware.jl, design principles, composable components, autoregressive example |
| Case studies | ~5 min | Renewal model, real-time nowcasting, ODE model |
| Wrap up | ~5 min | Summary, alternative approaches, future work, conclusions, TL;DR |
| **Total** | **~40 min** | |

## Rendering

From the project root:

```bash
task render-presentation
```

Or manually:

```bash
quarto render presentations/40min/index.qmd
```

## Viewing

After rendering, open `presentations/40min/index.html` in a browser, or use:

```bash
quarto preview presentations/40min/index.qmd
```

## Placeholder images needed

The following images need to be sourced and added to the presentation.
Screenshots or figures should be saved in a suitable location and referenced in `index.qmd`.

- *Whitty 2015 paper screenshot* (The gap slide 1)
- *Birrell et al. COVID-19 model screenshot* (The gap slide 2)
- *Endo et al. mpox paper screenshot* (The gap slide 3)
- *Hay et al. viral loads paper screenshot* (The gap: integrating diverse data)
- *Multi-model hub paper screenshot* (The gap: multi-model efforts)
- *ONS prevalence estimates screenshot* (Analysing data separately: the data)
- *Incidence and Rt estimates screenshot* (Analysing data separately: the cascade)
- *Policy paper screenshot* (Analysing data separately: the impact)
- *Lison et al. 2024 paper screenshot* (Joint modelling: the evidence)
- *Stan splash page screenshot* (PPLs reduce effort but not reuse)
- *epinowcast screenshot* (What happens when you try to be modular?)
- *Working draft paper screenshot* (A workflow for infectious disease modelling)
- *Workflow schematic figure* (Following the workflow exposes gaps)
- *Requirements table screenshot* (Summary of proposed requirements)
