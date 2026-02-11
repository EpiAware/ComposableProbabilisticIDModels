# 40-minute presentation

A 40-minute talk covering the full paper "Composable probabilistic models can lower barriers to rigorous infectious disease modelling".

## Planned timings

| Section | Duration | Slides |
|---|---|---|
| Disclaimer + TL;DR + Talk plan | ~1 min | 3 slides |
| Background | ~15 min | 20 slides: gap (x5), options, data cascade (x3), joint modelling (x2), PPLs, Rt ecosystem (x2), epinowcast, cross-domain pattern, workflow (x3), composability |
| Proposed requirements | ~5 min | 8 slides: overview, table, 6 themes |
| Our approach | ~7 min | 6 slides: overview, why DSL, DSL, composable apps, why Turing, Turing backend |
| Case studies | ~8 min | 12 slides: ARIMA (x3), renewal model (x3), nowcasting (x3), ODE model (x3) |
| Wrap up | ~4 min | 5 slides: summary, alternatives, future work, what I want, TL;DR |
| **Total** | **~40 min** | **54 slides** |

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

## Images

Images are stored in `presentations/figures/` and shared across presentations.

### Still needed

- *Birrell et al. screenshot* needs retaking at larger size
- *Workflow paper screenshot* needs retaking at larger size

### Sourced

All other images have been added to `presentations/figures/`.
