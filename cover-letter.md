# Cover Letter to PLOS Computational Biology

Dear Editor,

Mathematical models form an important part of epidemiological research.
They help synthesise data to inform infectious disease policy for both routine surveillance and outbreak response.
For evidence to inform policy it must be timely and rigorous, yet most modelling approaches struggle to achieve both.
During COVID-19, models integrating multiple data sources informed policy decisions, yet these were not adapted for the 2022 mpox outbreak where different expertise was needed.
Instead, new models were designed from scratch.
Similarly, multi-team forecasting collaborations combine outputs to improve forecasts, but teams rarely share model components despite shared goals.

This lack of transferability of model components between scenarios or teams represents a broader issue, in that the practical unit of reuse remains the whole model or its code base, not the underlying epidemiological concepts.
This does not just limit collaboration and dissemination of learning, but can have implications for statistical rigour.
As demonstrated by Lison et al. (PLOS Computational Biology, 2024), chaining the results of multiple models can lead to substantial bias compared to joint modelling which, however, usually requires bespoke models and associated code that cannot be separated into reusable parts.

We submit for consideration "Composable probabilistic models can lower barriers to rigorous infectious disease modelling" as an article that proposes a solution.
We present requirements for a framework that would allow sharing, combining and isolation of components of a model, and demonstrate feasibility through a proof of concept.
We then demonstrate the approach through three case studies recreating published analyses: an  analysis of COVID-19 in South Korea using a renewal model; an extension with reporting delays and day-of-week effects to replicate the model implemented in the R package EpiNow2; and an analysis of influenza outbreak data using an SIR model based on ordinary differential equations.

We think that this research will be relevant and appealing to a large part of the readership of _PLOS Computational Biology_, particularly the Epidemiology & Public Health section.
Those developing transmission models will find a novel approach to creating statistically principled joint models that remain adaptable.
Those working on computational statistics will find an application of state-of-the-art concepts in a domain where these haven't found widespread use.
Those conducting research in infectious disease epidemiology will find a concept that aims to lower the barrier for using infectious disease models.
The proof of concept implementation is open source with an interface in the widespread statistical computing language R.

All authors have approved the manuscript and declare no competing interests.

Yours sincerely,

Sam Abbott and Samuel P. C. Brand
(on behalf of all authors)
