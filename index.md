---
title       : FFTrees
subtitle    : Creating, visualizing, and implementing fast and frugal decision trees
author      : Nathaniel Phillips, University of Basel
job         : Reading Group, PWC, Zurich
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
bibliography : bibliography.bib
---







### Cook County Hospital, 1996

<img src="images/crowdedemergency.jpg" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="60%" style="display: block; margin: auto;" />

- 250,000 patients per year, Not enough space, Complete chaos

"As the city’s principal public hospital, Cook County was the place of last resort for the hundreds of thousands of Chicagoans without health insurance. Resources were stretched to the limit. The hospital’s cavernous wards were built for another century. There were no private rooms, and patients were separated by flimsy plywood dividers. There was no cafeteria or private telephone—just a payphone for everyone at the end of the hall. In one possibly apocryphal story, doctors once trained a homeless man to do routine lab tests because there was no one else available." Malcolm Gladwell, Blink.


--- &twocol

*** =left

## Heart attacks (?)

- 30 people a day worried about a heart attack
- **Coronary care bed** ($2,000 a night + 3 day stay) or **Regular bed**
- Goal: send true heart attacks to the coronary care bed, and true healthy patients to a normal bed.

### Multiple, uncertain measures

- Electrocardiogram (ECG), Blood pressure, Stethescope, How long? How much? During exercise? History? Cholesterol? Drugs? etc.


*** =right

<img src="images/paindecision.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="80%" style="display: block; margin: auto;" />


---

### Classic prediction problem

- Many cues (aka predictors, features), binary criterion

<img src="images/datadiagram.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="100%" style="display: block; margin: auto;" />

### Options

- Doctor's intuition
- Algorithm
    - Logistic Regression

---&twocol

## Solution: a fast and frugal tree (FFT)

***=left

- A fast and frugal decision tree (FFT) developed by Lee Goldman.
- Doctor's intuition accuracy: 75-90%
- Decision tree accuracy: 95%
- Tree had far fewer false-positives and huge cost savings
- To this day, the tree is still used at the hospital.

***=right

<img src="images/cooktree.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="70%" style="display: block; margin: auto;" />



--- &twocol

## Fast and Frugal Trees (FFTs)

***=left

#### Descriptive

- Inference (Gigerenzer & Goldstein, 1996)
- Judge's bailing decisions (Dhami, 2003)
- Competition "Tit-for-Tat" (Axelrod, 1984)
- Social "Imitate the successful" (Boyd & Richerson, 2005)

#### Prescriptive

- Heart disease (Breiman et al. 1993)
- Terrorist attacks (Garcia, 2016)
- Bank failure (Aikman et al., 2014; Neth et al., 2014)


***=right

<img src="images/nethfft.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="100%" style="display: block; margin: auto;" />

Neth et al. (2014). "Homo heuristicus in the financial world".


---

## Why use a Simple algorithm?

| | Complex|Simple |
|:---------|:----|:-----|
|     Example|    Regression, Random Forests, Bayes|Fast and Frugal Tree (FFT)|
|     Information Requirements|    High|Low     |
|     Search|    Comprehensive|Sequential     |
|     Speed|    Slow|Fast     |
| Transparency, ease of use| Medium or Low| High|

---&twocol
## FFTrees

***=left

- `FFTrees` An easy-to-use R package to create, visualize, and implement fast and frugal decision trees.

<br>
<div style="text-align:left"><font size="1"> Phillips et al. (under review). FFTrees: An R package to create, visualize, and implement fast and frugal decision trees</font></div>


***=right


```r
# Install FFTrees to R.
install.packages("FFTrees")
```



<img src="images/FFTrees_Logo.jpg" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" width="80%" style="display: block; margin: auto;" />


---

## Heart Disease Data


| age| sex|cp | trestbps| chol| fbs|restecg     | thalach| exang| oldpeak|slope | ca|thal   | diagnosis|
|---:|---:|:--|--------:|----:|---:|:-----------|-------:|-----:|-------:|:-----|--:|:------|---------:|
|  63|   1|ta |      145|  233|   1|hypertrophy |     150|     0|     2.3|down  |  0|fd     |         0|
|  67|   1|a  |      160|  286|   0|hypertrophy |     108|     1|     1.5|flat  |  3|normal |         1|
|  67|   1|a  |      120|  229|   0|hypertrophy |     129|     1|     2.6|flat  |  2|rd     |         1|
|  37|   1|np |      130|  250|   0|normal      |     187|     0|     3.5|down  |  0|normal |         0|
|  41|   0|aa |      130|  204|   0|hypertrophy |     172|     0|     1.4|up    |  0|normal |         0|
|  56|   1|aa |      120|  236|   0|normal      |     178|     0|     0.8|up    |  0|normal |         0|

- Regression: 6 significant cues (sex, cp, thalach, exang, oldpeak, ca)

---

## How trees are built with FFTrees

1. For each cue, calculate a decision threshold that maximizes accuracy *ignoring all other cues*.
2. Rank order cues by their maximum accuracy.
3. Select the top N (i.e., 4) most accurate cues
    - If any lower levels contain less than X\% (e.g., 10\%) of the data, remove them.
4. Select the exit structure with the highest accuracy.


---

## 3 Steps to creating FFTs with FFTrees


```r
# Step 0: Install FFTrees (v.1.2.0)
install.packages("FFTrees")

# Step 1: Load the package
library("FFTrees")

# Step 2: Create an fft decision model with FFTrees
heart.fft <- FFTrees(formula = diagnosis ~.,
                       data = heartdisease)
```

---


```r
# Show the cue accuracies
plot(heart.fft, what = "cues", main = "Heart cues")
```


<img src="figure/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" width="55%" style="display: block; margin: auto;" />


--- 


```r
plot(heart.fft, main = "Heart Disease FFT", stats = FALSE)
```


<img src="figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" width="70%" style="display: block; margin: auto;" />

--- 



```r
plot(heart.fft, main = "Heart FFT", decision.names = c("Healthy", "Diseased"))
```

<img src="figure/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" width="65%" style="display: block; margin: auto;" />


--- 

```r
plot(heart.fft, main = "Heart FFT", decision.names = c("Healthy", "Diseased"), tree = 6)
```

<img src="figure/unnamed-chunk-16-1.png" title="plot of chunk unnamed-chunk-16" alt="plot of chunk unnamed-chunk-16" width="65%" style="display: block; margin: auto;" />






---

### Prediction model competition

<img src="images/heartsim.png" title="plot of chunk unnamed-chunk-17" alt="plot of chunk unnamed-chunk-17" width="100%" style="display: block; margin: auto;" />



---&twocol
## Efficiency

***=left

- FFTs are very cheap to implement

- Heart disease data
    - Regression: $300
    - rpart: > $100
    - Heart disease FFT: $75.91

***=right

<img src="images/traintreestats.png" title="plot of chunk unnamed-chunk-18" alt="plot of chunk unnamed-chunk-18" width="100%" style="display: block; margin: auto;" />



---&twocol

***=left

## Generalizing FFTrees

- The `FFTrees` package can be used with any dataset with a binary criterion.
- Simulation: 10 diverse datasets taken from the UCI Machine Learning Database.
- FFTrees vs. regression, Naive Bayes, Random Forests and more

### How well can a simple fast and frugal tree predict data?  

***=right

<img src="images/datacollage.png" title="plot of chunk unnamed-chunk-19" alt="plot of chunk unnamed-chunk-19" width="90%" style="display: block; margin: auto;" />




---


```r
mushrooms.fft <- FFTrees(poisonous ~ ., data = mushrooms)
```

<img src="figure/unnamed-chunk-21-1.png" title="plot of chunk unnamed-chunk-21" alt="plot of chunk unnamed-chunk-21" width="55%" style="display: block; margin: auto;" />


---


```r
breast.fft <- FFTrees(diagnosis ~ ., data = breastcancer)
```

<img src="figure/unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" width="55%" style="display: block; margin: auto;" />





--- .class #id 
## Speed and frugality


<img src="figure/unnamed-chunk-24-1.png" title="plot of chunk unnamed-chunk-24" alt="plot of chunk unnamed-chunk-24" width="60%" style="display: block; margin: auto;" />


--- .class #id 
## Speed and frugality


<img src="figure/unnamed-chunk-25-1.png" title="plot of chunk unnamed-chunk-25" alt="plot of chunk unnamed-chunk-25" width="60%" style="display: block; margin: auto;" />



--- .class #id 
## Prediction accuracy across 10 dasets

<img src="images/simulationagg_c.png" title="plot of chunk unnamed-chunk-26" alt="plot of chunk unnamed-chunk-26" width="90%" style="display: block; margin: auto;" />


--- .class #id 

<img src="images/simulationseparate.png" title="plot of chunk unnamed-chunk-27" alt="plot of chunk unnamed-chunk-27" width="70%" style="display: block; margin: auto;" />



---

### When should I consider an FFT?

<img src="images/shouldiuseanfft.png" title="plot of chunk unnamed-chunk-28" alt="plot of chunk unnamed-chunk-28" width="80%" style="display: block; margin: auto;" />



---&twocol

***=left

### When will FFTres perform worse than regression?

1. Many cues each with weak validity and independent errors.

***=right

### When can FFTrees do better than regression?

1. A few cues with high validity


---&twocol

***=left

### Next steps

1. Incorporate numerical cue costs in algorithm.
2. Re-write code in C++ for speed.
3. Quantify changes in data over time.

***=right




---&twocol
## Collaborators

***=left

- Wolfgang Gaissmaier (University of Konstanz)
- Hansjoerg Neth  (University of Konstanz)
- Jan Woike  (MPI for Human Development)

***=right

<img src="images/collaboratos.png" title="plot of chunk unnamed-chunk-30" alt="plot of chunk unnamed-chunk-30" width="90%" style="display: block; margin: auto;" />




--- .class #id 

### FFTrees

#### My Links

- This presentation: [https://ndphillips.github.io/UZurich-6April2017/](https://ndphillips.github.io/UZurich-6April2017/)
- Website: https://ndphillips.github.io
- Email: Nathaniel.D.Phillips.is@gmail.com

#### Packages

- FFTrees: `install.packages("FFTrees")`
- yarrr: `install.packages("yarrr")`



--- &twocol

*** =left
## FFTrees algorithm

1. Calculate a decision threshold `t` for each cue that maximizes the cue’s balanced accuracy `bacc` in training.

2. Rank cues in order of their maximum balanced accuracy -- select the top N cues. 

3. Creates all possible `2^{N−1}` trees with these cues, using all exit structures.

*** =right

<img src="figure/unnamed-chunk-31-1.png" title="plot of chunk unnamed-chunk-31" alt="plot of chunk unnamed-chunk-31" width="504" style="display: block; margin: auto;" />



---&twocol

## Complexity vs. Simplicity

***=left

<br>

<img src="images/complexity.jpg" title="plot of chunk unnamed-chunk-32" alt="plot of chunk unnamed-chunk-32" width="100%" style="display: block; margin: auto;" />

***=right

<br>

<img src="images/decisionsimple.jpg" title="plot of chunk unnamed-chunk-33" alt="plot of chunk unnamed-chunk-33" width="95%" style="display: block; margin: auto;" />


---

<img src="figure/unnamed-chunk-34-1.png" title="plot of chunk unnamed-chunk-34" alt="plot of chunk unnamed-chunk-34" width="80%" style="display: block; margin: auto;" />

---

<img src="figure/unnamed-chunk-35-1.png" title="plot of chunk unnamed-chunk-35" alt="plot of chunk unnamed-chunk-35" width="80%" style="display: block; margin: auto;" />


---

<img src="figure/unnamed-chunk-36-1.png" title="plot of chunk unnamed-chunk-36" alt="plot of chunk unnamed-chunk-36" width="80%" style="display: block; margin: auto;" />

---

<img src="figure/unnamed-chunk-37-1.png" title="plot of chunk unnamed-chunk-37" alt="plot of chunk unnamed-chunk-37" width="80%" style="display: block; margin: auto;" />

---

<img src="figure/unnamed-chunk-38-1.png" title="plot of chunk unnamed-chunk-38" alt="plot of chunk unnamed-chunk-38" width="80%" style="display: block; margin: auto;" />



