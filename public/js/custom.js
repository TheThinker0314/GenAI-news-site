document.addEventListener("DOMContentLoaded", function() {
  const images = document.querySelectorAll('img');
  images.forEach(img => {
    img.setAttribute('loading', 'lazy');
    img.alt = img.alt || 'GenAI Site Graphic';
  });

  const scrollBtn = document.createElement("button");
  scrollBtn.innerHTML = "&uarr;";
  scrollBtn.style.position = "fixed";
  scrollBtn.style.bottom = "20px";
  scrollBtn.style.right = "20px";
  scrollBtn.style.display = "none";
  scrollBtn.style.padding = "10px 15px";
  scrollBtn.style.fontSize = "18px";
  scrollBtn.style.border = "none";
  scrollBtn.style.borderRadius = "50%";
  scrollBtn.style.backgroundColor = "var(--primary-color)";
  scrollBtn.style.color = "white";
  scrollBtn.style.cursor = "pointer";
  scrollBtn.style.zIndex = "1000";
  document.body.appendChild(scrollBtn);

  window.addEventListener("scroll", function() {
    if (window.scrollY > 300) {
      scrollBtn.style.display = "block";
    } else {
      scrollBtn.style.display = "none";
    }
  });

  scrollBtn.addEventListener("click", function() {
    window.scrollTo({ top: 0, behavior: "smooth" });
  });
});
