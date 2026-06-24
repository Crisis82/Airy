# Airy

Light-font pastel-colored LaTeX templates inspired by the [Thud](https://github.com/miculan/thud) template, designed to give a fresh, modern and calming feeling to scientific papers and presentations.

The classes provided in this repository are:
- **academica**: built upon the standard *book* class (*i.e.*, papers/articles/journals);
- **presenta**: built upon the standard *beamer* class (*i.e.*, slides).

## Configuration

To apply any of these templates, just copy the content of class folder that you want to use (*e.g.*, **academica** or **presenta**) into your working folder.

If you want to use the light fonts such as Inter or Outfit, you should copy the font folder and specify the relative path of the folder inside the class.
Otherwise, you can globally install the font with
```sh
mkdir -p ~/.local/share/fonts
cp -r ./fonts ~/.local/share/fonts
fc-cache -fv
```
In this way the font will be loaded automatically.

Then, you just need to specify the name of the template as the documentclass, e.g.

```tex
\documentclass{academica}
```

For each class is provided an example file (`example.tex`) and template one (`main.tex`).

## Compilation

It's also provided [biblatex](./biblatex), which is a simple bash script to compile the latex file using lualatex and biber.
