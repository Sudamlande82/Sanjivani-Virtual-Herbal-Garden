<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="search_result.aspx.cs" Inherits="search_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <title>Search Results - Virtual Herbal Garden</title>

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

/* CONTENT */
.container{
  max-width:1200px;
  margin:auto;
  padding:20px;
}

/* Search Bar */
.search-bar{
  display:flex;
  gap:10px;
  margin-bottom:20px;
}

.search-bar input{
  flex:1;
  padding:12px;
  border:1px solid #ccc;
  border-radius:10px;
  font-size:16px;
  outline:none;
}

.btn{
  padding:12px 16px;
  background:var(--accent);
  color:white;
  border:none;
  border-radius:10px;
  cursor:pointer;
  font-weight:600;
}

.btn:hover{
  background:var(--accent-light);
}

/* Filters */
.filters{
  display:flex;
  flex-wrap:wrap;
  gap:20px;
  margin-bottom:20px;
}

.filter-group select{
  padding:10px;
  border-radius:8px;
  border:1px solid #ccc;
  font-size:14px;
}

.filter-group label{
  font-weight:600;
}

/* Plant Grid */
.grid{
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
  gap:20px;
}

.card{
  background:var(--card);
  border-radius:12px;
  overflow:hidden;
  box-shadow:var(--shadow);
  transition:0.2s;
}

.card:hover{
  transform:translateY(-6px);
}

.card img{
  width:100%;
  height:150px;
  object-fit:cover;
}

.card-body{
  padding:12px;
}

.card-body h3{
  margin:0 0 6px 0;
  font-size:18px;
}

.card-body p{
  margin:0;
  font-size:14px;
  color:var(--muted);
}

/* No results */
.empty{
  grid-column:1/-1;
  text-align:center;
  color:var(--muted);
  font-size:18px;
  padding:20px;
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
<div class="container">

  <!-- Search Bar -->
  <div class="search-bar">
    <input type="text" id="searchInput" placeholder="Search again (e.g., Tulsi, Fever)" />
    <button class="btn" onclick="applyFilters()">Search</button>
  </div>

  <!-- Showing Results -->
  <h3 id="searchHeading">Showing results for: <span style="color:var(--accent)">Tulsi</span></h3>

  <!-- Filters -->
  <div class="filters">

    <div class="filter-group">
      <label>Category</label>
      <select id="categoryFilter">
        <option value="all">All</option>
        <option>Immunity</option>
        <option>Diabetes</option>
        <option>Skin Care</option>
        <option>Digestion</option>
        <option>Cold & Cough</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Ailment</label>
      <select id="ailmentFilter">
        <option value="all">All</option>
        <option>Fever</option>
        <option>Cold</option>
        <option>Diabetes</option>
        <option>Skin Infection</option>
        <option>Stress</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Plant Type</label>
      <select id="typeFilter">
        <option value="all">All</option>
        <option>Leafy</option>
        <option>Root</option>
        <option>Fruit</option>
        <option>Herb</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Sort By</label>
      <select id="sortFilter">
        <option value="az">Aâ€“Z</option>
        <option value="viewed">Most Viewed</option>
        <option value="recent">Recently Added</option>
      </select>
    </div>

  </div>

  <!-- Results Grid -->
  <div class="grid" id="resultsGrid"></div>

</div>


<script>
/* NAV TOGGLE */
function toggleNav(){
  document.getElementById('navLinks').classList.toggle('show');
}

/* SAMPLE DATA (Replace with backend data) */
const PLANTS = [
  {
    name:"Tulsi",
    desc:"Boosts immunity, useful for cold & cough",
    category:"Immunity",
    ailment:"Cold",
    type:"Leafy",
    views:520,
    added:2,
    img:"https://picsum.photos/seed/tulsi/600/400"
  },
  {
    name:"Neem",
    desc:"Skin care antibacterial plant",
    category:"Skin Care",
    ailment:"Skin Infection",
    type:"Leafy",
    views:410,
    added:4,
    img:"https://picsum.photos/seed/neem/600/400"
  },
  {
    name:"Aloe Vera",
    desc:"Great for digestion and skin",
    category:"Digestion",
    ailment:"Indigestion",
    type:"Herb",
    views:690,
    added:1,
    img:"https://picsum.photos/seed/aloe/600/400"
  }
];

/* RENDER PLANTS */
function renderPlants(list){
  const grid = document.getElementById("resultsGrid");
  grid.innerHTML = "";

  if(list.length === 0){
    grid.innerHTML = `<div class='empty'>No matching plants found.</div>`;
    return;
  }

  list.forEach(p=>{
    grid.innerHTML += `
      <div class="card">
        <img src="${p.img}" alt="${p.name}">
        <div class="card-body">
          <h3>${p.name}</h3>
          <p>${p.desc}</p>
        </div>
      </div>
    `;
  });
}

/* FILTER FUNCTION */
function applyFilters(){
  let q = document.getElementById("searchInput").value.toLowerCase();
  let category = document.getElementById("categoryFilter").value;
  let ailment = document.getElementById("ailmentFilter").value;
  let type = document.getElementById("typeFilter").value;
  let sort = document.getElementById("sortFilter").value;

  document.getElementById("searchHeading").innerHTML = 
    `Showing results for: <span style='color:var(--accent)'>${q || "All"}</span>`;

  let results = PLANTS.filter(p=>{
    return (category==="all" || p.category===category) &&
           (ailment==="all" || p.ailment===ailment) &&
           (type==="all" || p.type===type) &&
           (p.name.toLowerCase().includes(q) || p.desc.toLowerCase().includes(q));
  });

  /* Sorting */
  if(sort==="az"){
    results.sort((a,b)=>a.name.localeCompare(b.name));
  } else if(sort==="viewed"){
    results.sort((a,b)=>b.views - a.views);
  } else if(sort==="recent"){
    results.sort((a,b)=>a.added - b.added);
  }

  renderPlants(results);
}

/* INITIAL LOAD */
renderPlants(PLANTS);
</script>

</asp:Content>

