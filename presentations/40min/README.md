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
