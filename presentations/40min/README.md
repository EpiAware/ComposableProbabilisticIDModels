# 40-minute presentation

A 40-minute talk covering the full paper "Composable probabilistic models can lower barriers to rigorous infectious disease modelling".

## Planned timings

| Section | Duration | Slides |
|---|---|---|
| Introduction | 15 min | The gap, ONS example, Rt ecosystem, Bayesian workflow, composability |
| Proposed requirements | 5 min | Requirements for a composable framework |
| Proof of concept | 10 min | EpiAware.jl, design principles, composable components, autoregressive example |
| Case studies | 5 min | Renewal model, real-time nowcasting, ODE model |
| Discussion | 5 min | Summary, alternative approaches, future work, conclusions |
| **Total** | **40 min** | |

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
