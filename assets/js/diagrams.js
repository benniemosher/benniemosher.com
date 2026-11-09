// Turn fenced ```mermaid blocks into styled SVG diagrams (Nord palette, light or
// dark to match the visitor's color scheme).
// Loaded only on posts with `mermaid: true` in the front matter.
var lightTheme = {
  fontFamily: "Raleway, Helvetica, Arial, sans-serif",
  fontSize: "15px",
  background: "#eceff4",
  primaryColor: "#e5e9f0",
  primaryTextColor: "#2e3440",
  primaryBorderColor: "#5e81ac",
  secondaryColor: "#d8dee9",
  tertiaryColor: "#eceff4",
  lineColor: "#4c566a",
  textColor: "#2e3440",
  edgeLabelBackground: "#eceff4"
};

var darkTheme = {
  fontFamily: "Raleway, Helvetica, Arial, sans-serif",
  fontSize: "15px",
  background: "#3b4252",
  primaryColor: "#434c5e",
  primaryTextColor: "#eceff4",
  primaryBorderColor: "#88c0d0",
  secondaryColor: "#4c566a",
  tertiaryColor: "#3b4252",
  lineColor: "#d8dee9",
  textColor: "#eceff4",
  edgeLabelBackground: "#3b4252"
};

document.addEventListener("DOMContentLoaded", function () {
  var blocks = document.querySelectorAll("div.language-mermaid, pre > code.language-mermaid");
  if (!blocks.length || !window.mermaid) {
    return;
  }

  blocks.forEach(function (block) {
    var source = block.querySelector("code") || block;
    var target = block.tagName === "CODE" ? block.parentNode : block;
    var diagram = document.createElement("div");
    diagram.className = "mermaid";
    diagram.dataset.source = source.textContent;
    diagram.textContent = source.textContent;
    target.replaceWith(diagram);
  });

  var scheme = window.matchMedia("(prefers-color-scheme: dark)");

  // Mermaid bakes colors into the SVG, so a theme change means rendering again
  // from the saved source.
  function render() {
    window.mermaid.initialize({
      startOnLoad: false,
      theme: "base",
      securityLevel: "strict",
      themeVariables: scheme.matches ? darkTheme : lightTheme,
      flowchart: {
        curve: "basis",
        htmlLabels: true,
        padding: 14,
        wrappingWidth: 340,
        nodeSpacing: 40,
        rankSpacing: 48
      }
    });
    document.querySelectorAll(".mermaid").forEach(function (diagram) {
      diagram.removeAttribute("data-processed");
      diagram.textContent = diagram.dataset.source;
    });
    window.mermaid.run({ querySelector: ".mermaid" });
  }

  // Wait for the web fonts, or Mermaid measures labels in the fallback font and
  // clips them.
  var ready = document.fonts && document.fonts.ready ? document.fonts.ready : Promise.resolve();
  ready.then(render);
  scheme.addEventListener("change", render);
});
