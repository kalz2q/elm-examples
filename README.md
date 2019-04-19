# elm-projects
Learning Elm 0.19

According to my current premmature knowledge , 
```
elm make src/something.elm
```
makes index.html at the top of project directory. 

In order to make a child html files, I do the following. 
```
elm make src/anotherfile.elm --output=anotherfile.html
```
I will make index.html to refer to anotherfile.html 

this way I can make many elm and html files to show to others. 

[link to html](https://kalz2q.github.io/elm-projects/) 

[source fiels are](https://github.com/kalz2q/elm-projects) 

so, now you can see the resulting html files directory or `git clone` everything and see by 
```
elm reactor
```
enjoy!
