# Banner generator

To generate a banner for this template, add your logo under the [logos](./logos/) folder and fix the parameters of logo and text used by `banner.tex`.

Under [outputs](./outputs/) are already provided some generated banners.

> [!IMPORTANT]
> If in the main class you need PDF/A compliance, it's crucial that the logos used have no transparency at all.
> If it happens that the logo provided by the university is transparent, then you can use
> ```
>   magick logos/image.png -background white -alpha remove -alpha off logos/image_out.png
> ```
> and replace the transparent layer with white.
