<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="plantdetails.aspx.cs" Inherits="plantdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <title>Plant Details - Virtual Herbal Garden</title>

<style>
:root{
  --bg:#f4faf4;
  --card:#ffffff;
  --accent:#1f7a3a;
  --accent-light:#2aa06c;
  --muted:#6b7280;
  --shadow:0 6px 16px rgba(0,0,0,0.08);
  font-family:Inter,Segoe UI,Roboto,sans-serif;
}

body{
  margin:0;
  background:var(--bg);
}

/* NAVBAR */
.navbar{
  background:var(--card);
  box-shadow:0 4px 12px rgba(0,0,0,0.06);
  padding:14px 22px;
  display:flex;
  justify-content:space-between;
  align-items:center;
  position:sticky;
  top:0;
  z-index:10;
}

.navbar .logo{
  font-size:20px;
  font-weight:700;
  color:var(--accent);
}

.nav-links{
  display:flex;
  gap:20px;
}

.nav-links a{
  text-decoration:none;
  color:#1b2a1d;
  font-weight:600;
  padding:8px;
  border-radius:6px;
}

.nav-links a:hover{
  background:#e9f7ee;
  color:var(--accent);
}

/* Burger (Mobile) */
.burger{
  display:none;
  font-size:26px;
  cursor:pointer;
}

@media(max-width:768px){
  .nav-links{
    position:absolute;
    top:60px;
    right:0;
    background:white;
    flex-direction:column;
    padding:20px;
    width:200px;
    display:none;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
  }
  .nav-links.show{ display:flex; }
  .burger{ display:block; }
}

/* PAGE CONTENT */
.container{
  max-width:1100px;
  margin:auto;
  padding:20px;
}

h2{
  font-size:28px;
  margin-bottom:5px;
}

h3{
  margin-top:40px;
  font-size:22px;
  margin-bottom:8px;
}

/* Image */
.plant-image{
  width:100%;
  height:380px;
  border-radius:14px;
  overflow:hidden;
  box-shadow:var(--shadow);
}

.plant-image img{
  width:100%;
  height:100%;
  object-fit:cover;
}

/* Details Grid */
.details{
  margin-top:20px;
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:20px;
}

.card{
  padding:20px;
  background:var(--card);
  border-radius:12px;
  box-shadow:var(--shadow);
}

.label{
  font-weight:600;
  color:#0f2010;
}

/* Parts used tags */
.tag{
  display:inline-block;
  background:#e9f8ee;
  border:1px solid #c0e7ce;
  padding:6px 10px;
  border-radius:999px;
  font-size:13px;
  margin-right:6px;
  margin-bottom:6px;
}

/* Save button */
.btn{
  margin-top:20px;
  padding:12px 18px;
  background:var(--accent);
  color:white;
  border:none;
  border-radius:10px;
  cursor:pointer;
  font-weight:600;
  font-size:16px;
}

.btn:hover{
  background:var(--accent-light);
}

/* Related Plants */
.related-grid{
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
  gap:20px;
}

.related-card{
  background:var(--card);
  border-radius:12px;
  overflow:hidden;
  box-shadow:var(--shadow);
  cursor:pointer;
  transition:transform 0.2s ease;
}

.related-card:hover{
  transform:translateY(-5px);
}

.related-card img{
  width:100%;
  height:140px;
  object-fit:cover;
}

.related-card-body{
  padding:12px;
}

/* Comments */
.comment-box{
  background:var(--card);
  padding:20px;
  border-radius:12px;
  box-shadow:var(--shadow);
}

.comment{
  background:#f5fff5;
  padding:12px;
  margin:10px 0;
  border-radius:10px;
  border-left:4px solid var(--accent);
}

textarea{
  width:100%;
  padding:12px;
  border:1px solid #ccc;
  border-radius:10px;
  font-size:15px;
  min-height:80px;
}

/* Rating stars */
.stars span{
  font-size:24px;
  color:#ccc;
  cursor:pointer;
}

.stars span.active{
  color:#f5b301;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
<div class="container">

  <!-- Plant Image -->
  <div class="plant-image">
    <img id="plantImg" src="https://picsum.photos/seed/tulsi/1200/800">
  </div>

  <!-- Title -->
  <h2 id="commonName">Tulsi (Holy Basil)</h2>
  <p style="color:var(--muted)">Scientific Name: <strong id="scientificName">Ocimum Sanctum</strong></p>

  <!-- Details Grid -->
  <div class="details">

    <div class="card">
      <h3>General Information</h3>
      <p><span class="label">Family:</span> Lamiaceae</p>
      <p><span class="label">Medicinal Uses:</span></p>
      <p id="medicinalUses">Immunity booster, treats cough, improves digestion.</p>
      <p><span class="label">Parts Used:</span></p>
      <div id="partsUsed"></div>
    </div>

    <div class="card">
      <h3>Benefits</h3>
      <p id="benefits">
        Rich in antioxidants, supports lungs, reduces stress.
      </p>

      <h3 style="margin-top:20px;">Cultivation Method</h3>
      <p id="cultivation">
        Needs warm climate, partial sunlight, daily light watering.
      </p>
    </div>

  </div>

  <!-- Save to Favorites -->
  <button class="btn" onclick="saveFavorite()">Save to Favorites</button>

  <!-- Related Plants -->
  <h3>Related Plants</h3>
  <div class="related-grid" id="relatedPlants"></div>

  <!-- Comments -->
  <h3>Comments & Ratings</h3>
  <div class="comment-box">

    <div class="stars" id="ratingStars">
      <span data-rate="1">★</span>
      <span data-rate="2">★</span>
      <span data-rate="3">★</span>
      <span data-rate="4">★</span>
      <span data-rate="5">★</span>
    </div>

    <textarea id="commentText" placeholder="Write your comment..."></textarea>
    <button class="btn" onclick="submitComment()">Submit Comment</button>

    <h3>User Reviews</h3>
    <div id="commentsList"></div>

  </div>

</div>

<script>
/* NAV TOGGLE */
function toggleNav(){
  document.getElementById('navLinks').classList.toggle('show');
}

/* SAMPLE DATA */
const plant = {
  name:"Tulsi",
  scientific:"Ocimum Sanctum",
  family:"Lamiaceae",
  uses:"Immunity booster, cough, digestion.",
  parts:["Leaves","Seeds","Roots"],
  benefits:"Excellent for immunity & respiratory health.",
  cultivation:"Warm climate, partial sun, light watering.",
  related:[
    {name:"Neem", img:"https://picsum.photos/seed/neem/600/400"},
    {name:"Aloe Vera", img:"https://picsum.photos/seed/aloe/600/400"},
    {name:"Ashwagandha", img:"https://picsum.photos/seed/ashwa/600/400"}
  ]
};

/* LOAD PLANT DATA */
document.getElementById("commonName").textContent = plant.name;
document.getElementById("scientificName").textContent = plant.scientific;
document.getElementById("medicinalUses").textContent = plant.uses;
document.getElementById("benefits").textContent = plant.benefits;
document.getElementById("cultivation").textContent = plant.cultivation;

/* Parts Used */
document.getElementById("partsUsed").innerHTML =
  plant.parts.map(p => `<span class='tag'>${p}</span>`).join("");

/* Related */
document.getElementById("relatedPlants").innerHTML =
  plant.related.map(r=>`
    <div class="related-card">
      <img src="${r.img}">
      <div class="related-card-body"><strong>${r.name}</strong></div>
    </div>`).join("");

/* Favorite */
function saveFavorite(){
  alert("Added to favorites!");
}

/* Ratings */
const stars = document.querySelectorAll("#ratingStars span");
stars.forEach(star => {
  star.onclick = function(){
    stars.forEach(s=>s.classList.remove("active"));
    let rate = this.dataset.rate;
    for(let i=0;i<rate;i++){ stars[i].classList.add("active"); }
  };
});

/* Comments */
function submitComment(){
  let txt = document.getElementById("commentText").value.trim();
  if(!txt){
    alert("Write a comment first!");
    return;
  }
  document.getElementById("commentsList").innerHTML +=
    `<div class="comment"><strong>You</strong><br>${txt}</div>`;
  document.getElementById("commentText").value = "";
}
</script>


</asp:Content>

