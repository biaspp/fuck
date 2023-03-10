# Fuck 𓆩♡𓆪
Przeprowadzono analizę zbioru danych z użyciem języka R, aby uzyskać wgląd w związki pomiędzy zmiennymi oraz wyłonić istotne cechy zbioru. ✩˖ ࣪‧₊˚໒꒱⋆✩
# Case
Analizowane dane zawierają informacje na temat ilości padającego słowa “f*ck” w 143 wybranych anglojęzycznych filmach na przestrzeni prawie 50 lat. Ponadto dołączona jest informacja o długości filmów - w minutach, oraz klasyfikacja obserwacji do grup na podstawie daty ich premiery, w następującym systemie:
-	premiera w latach 2012 - 2022: “nowy”
-	premiera w latach 2001 - 2012: “średni”
-	premiera w latach 1978 - 2001: “stary.

W celu przetestowania hipotezy, mówiącej o istotnym wpływie daty premiery filmu na ilość pojawiającego się w nim słowa “f*ck” przeprowadzono jednoczynnikową analizę wariancji w schemacie międzygrupowym. Jej wyniki wykazały, że pomiędzy filmami z trzech porównywanych grup - nowymi, średnimi i starymi, występują różnice w ilości wypowiadanego słowa “f*ck”; F(2, 138) = 14.16; p < 0,001; cząstkowe eta2 = 0,17; 95% CI [0.08, 1.00]. 
Wbrew oczekiwaniom najmniej słów “f*ck” pojawiało się w filmach nowych (N = 38; M = 167; SD = 14.8), a najwięcej w filmach średnich (N = 53; M = 219; SD = 63,0), plasując filmy stare na środkowej pozycji (N = 50; M = 198; SD = 41,1).

 ![wykres1](https://user-images.githubusercontent.com/94643456/224188777-0f8b1ef7-8deb-41bf-b0e0-682155937dcf.jpg)


Następnie w celu zbadania, które grupy różnią się od siebie istotnie statystycznie wykonano testy post hoc z poprawką Bonferroniego. Uzyskane wyniki ujawniły dwa istotne efekty - w nowych filmach słowo “f*ck” padało mniej razy, niż w filmach średnich (p < 0,001; d Cohena = -1,168), a także mniej razy niż w filmach starych, chociaż ten drugi efekt miał mniejszą istotność statystyczną (p = 0,015; d Cohena = -0,903). 

<img width="451" alt="wykres2" src="https://user-images.githubusercontent.com/94643456/224188817-5d3ac818-859e-46b6-b6bb-817eb1f9e70c.png">

Jedyny efekt nieistotny wystąpił pomiędzy filmami z grupy średniej i starej (p = 0,077; d Cohena = 0,403) świadcząc tym samym o braku różnic pomiędzy ilością używanego w nich słowa “f*uck”.
 
![wykres 3](https://user-images.githubusercontent.com/94643456/224188870-ec957901-8b9d-4950-8ec1-4894f6490548.png)

 
## Legenda:
### Dane:
* fuck_og - plik z danymi pobrany z: https://www.kaggle.com/datasets/devrimtuner/list-of-films-that-most-frequently-use-the-word
* fuck - obrobione dane do analizy (podzielone na grupy, usunięci outlierzy)
### Skrypty:
* s1 - anova jednoczynnikowa
* s2 - anova dwuczynnikowa(chciałam sprawdzić czy długość filmu różnicuje, ale okazało się, że nie, więc pominęłam)
