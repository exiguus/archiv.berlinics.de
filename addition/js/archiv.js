function archiv() {
  var element = document.createElement('button');
  element.setAttribute('id', 'archiv');
  element.setAttribute('class', 'archiv');
  element.textContent = 'archiviert';
  element.style = `
    position: fixed;
    bottom: 6rem;
    right: 4rem;
    background: orange;
    color: black;
    border: 2px solid black;
    border-radius: 0.5rem;
    padding: 0.5rem 1rem;
    font-size: 1rem;
    `;
  element.addEventListener('click', function () {
    archiv_open();
  });
  document.body.appendChild(element);
}
function archiv_open() {
  var element = document.createElement('div');
  element.setAttribute('id', 'archiv-overlay');
  element.setAttribute('class', 'archiv-overlay');
  element.innerHTML = `
   <div class="archiv-header" style="margin-bottom: 2rem">
      <h2>archiviert</h2>
    </div>
    <ul class="archiv-content" style="margin: 0 2rem 2rem 0">
      <li style="padding: 0.5rem; list-style: disc">Die Seiten sind nicht mehr aktuell und werden nicht mehr gepflegt</li>
      <li style="padding: 0.5rem; list-style: disc">Seit 2023 ist die Seite archiviert</li>
      <li style="padding: 0.5rem; list-style: disc">Seit 2013 hat sich der Inhalt der Seite nicht mehr geändert</li>
      <li style="padding: 0.5rem; list-style: disc">Einige Funktion der Seite wie die Suche oder der RSS-Feed funktionieren nicht mehr</li>
    </ul>
    <a href="javascript:archiv_close();">Schließen</a>
   `;
  element.style = `
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   padding: 4rem;
   font-size: 1.5rem;
   background-color: rgba(255,255,255,0.9);
   z-index: 100;
   `;
  document.body.appendChild(element);
}

function archiv_close() {
  document.getElementById('archiv-overlay').remove();
}

window.onload = function () {
  archiv();
};
