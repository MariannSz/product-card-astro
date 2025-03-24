# Elm + Tailwind Product Card Component

This is a fully responsive, dynamic product card component built with Elm, Tailwind CSS, and Astro. It showcases a grid of product cards similar to Bellroy’s product listings, featuring:

- Product images
- Title, price range, and description
- Color selectors
- "Show Inside" toggle button
- Optional product tag (like Bestseller)

The component is packaged as part of an Astro build - integration of Elm into an Astro + Tailwind workflow.

## 🛠️ Tech Stack

- **Elm**: Frontend logic and dynamic interactivity
- **Tailwind CSS**: Styling and layout
- **Astro**: Build tool & bundler
- **npm scripts**: For building Elm & running Astro dev server

## 🚀 Installation & Usage

1. Clone the repo:

```bash
git clone <your-repo-url>
cd <your-repo-folder>
```

2. Install dependencies:

```bash
npm install
```

3. Start development server (this builds Elm & runs Astro):

```bash
npm run start
```

4. Visit:

```
http://localhost:4321
```

## 📂 Folder Structure

```text
/
├── public/
│   ├── main.js        # Compiled Elm output
│   └── product.json   # Product data
├── src/
│   ├── layouts/
│   │   └── Layout.astro
│   ├── pages/
│   │   └── index.astro
│   ├── styles/
│   │   └── global.css
│   └── *.elm          # Elm source files (ProductCard.elm, Main.elm, etc.)
└── package.json
```

## 📝 Features

- Dynamic product grid based on JSON data
- Responsive layout with Tailwind
- Interactive color selector
- Toggleable "Show Inside" button with animated icon
- Optional product tags per card (e.g., Bestseller)
- Clean, maintainable code structure

## 📸 Screenshots

![Product cards on large screen](screenshots/product-cards-lg.png?raw=true "Product Cards - Large Screen")
![Product cards on medium screen](screenshots/product-cards-md.png?raw=true "Product Cards - Medium Screen")
![Product cards on small screen](screenshots/product-cards-sm.png?raw=true "Product Cards - Small Screen")
![Product cards on mobile screen](screenshots/product-cards-mobile.png?raw=true "Product Cards - Mobile Screen")

---

## 🌐 License

MIT
