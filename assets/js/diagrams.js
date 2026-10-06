// Turn fenced ```mermaid blocks into styled SVG diagrams (Nord palette).
// Loaded only on posts with `mermaid: true` in the front matter.
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
    diagram.textContent = source.textContent;
    target.replaceWith(diagram);
  });

  window.mermaid.initialize({
    startOnLoad: false,
    theme: "base",
    securityLevel: "strict",
    themeVariables: {
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
    },
    flowchart: {
      curve: "basis",
      htmlLabels: true,
      padding: 14,
      nodeSpacing: 40,
      rankSpacing: 48
    }
  });
  window.mermaid.run({ querySelector: ".mermaid" });
});
