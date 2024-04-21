# Fórmulas booleanas y restricciones lineales

Para construir el sistema de restricciones lineales partimos de una condición _if then else_.
Para un $N \gg m$ siendo $m$ el número de robots se define una condición $N \cdot x \geq V \cdot m$ que indica que si un hay un robot en esta región se cumple y si no se cumplirá la condición $x \leq V \cdot m$.

Además podemos definir la misión mediante una fórmula booleana. Por ejemplo, para este entorno, $!A\&B$, es decir, la región $A$ correspondiente  a $\Pi_1$ es un obstáculo y/o no queremos robots en esa región. Y queremos que haya al menos un robot en la región $B$ correspondiente a $\Pi_2$. Es decir $A \leq 0$ y $B \geq 1$.

Mediante la función `formula2constraints` obtenemos la ecuación en forma matricial $\Delta \cdot Var \leq b$.
