document.addEventListener("turbo:load", function () {
  const percentageValue = document.getElementById("percentageValue");
  const percentage = percentageValue.getAttribute("data-percentage");
  const percentageRing = document.getElementById("percentageRing");
  percentageRing.style.setProperty("--percentage", `${percentage}%`);
});
