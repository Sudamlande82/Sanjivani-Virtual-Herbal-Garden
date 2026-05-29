<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <title>About - Virtual Herbal Garden</title>

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
  color:#1b2a1d;
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

.logo{
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
  background:#e0f6e8;
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
    width:200px;
    padding:20px;
    display:none;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
  }
  .nav-links.show{ display:flex; }
  .burger{ display:block; }
}

/* PAGE CONTENT */
.container{
  max-width:900px;
  margin:auto;
  padding:25px;
}

h2{
  font-size:32px;
  margin-bottom:15px;
}

h3{
  font-size:22px;
  margin-bottom:10px;
  color:var(--accent);
}

p{
  font-size:16px;
  line-height:1.6;
  color:#1b2a1d;
}

/* Cards */
.card{
  background:var(--card);
  padding:20px;
  margin-top:25px;
  border-radius:12px;
  box-shadow:var(--shadow);
}

/* Footer */
footer{
  background:var(--accent);
  color:white;
  padding:30px 20px;
  margin-top:40px;
}

footer .footer-container{
  max-width:1100px;
  margin:auto;
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
  gap:20px;
}

footer h4{
  margin-bottom:12px;
  font-size:18px;
}

footer p, footer a{
  font-size:14px;
  line-height:1.6;
  color:white;
  text-decoration:none;
}

footer a:hover{
  text-decoration:underline;
}

footer .copyright{
  text-align:center;
  margin-top:20px;
  font-size:14px;
  opacity:0.9;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
<div class="container">

  <h2>About Virtual Herbal Garden</h2>
  <p style="color:var(--muted);margin-top:-8px;">
    Learn about the purpose, importance, and scope of this digital herbal knowledge platform.
  </p>

  <!-- Objective -->
  <div class="card">
    <h3>Objective</h3>
    <p>
      The <strong>Virtual Herbal Garden</strong> aims to provide an accessible, interactive, 
      and educational digital platform about medicinal plants.  
      It helps users identify herbs, understand their medicinal properties, and learn cultivation methods.
    </p>
    <p>
      The platform promotes natural healing, traditional medicinal knowledge, and environmental sustainability.
    </p>
  </div>

  <!-- Importance -->
  <div class="card">
    <h3>Importance of Medicinal Plants</h3>
    <p>
      Medicinal plants are nature’s pharmacy. They have been used for thousands of years in traditional medicines
      such as Ayurveda, Siddha, and Homeopathy. Many herbs like Tulsi, Neem, Aloe Vera, and Ashwagandha
      contain active medicinal compounds that support immunity, digestion, stress relief, and more.
    </p>
    <p>
      As awareness grows toward organic living and natural remedies, this platform makes knowledge easily accessible.
    </p>
  </div>

  <!-- Scope -->
  <div class="card">
    <h3>Project Scope</h3>
    <ul style="margin-left:20px; line-height:1.7;">
      <li>Information on various medicinal plants including uses, benefits, and cultivation.</li>
      <li>Search, filter, and category browsing for easy navigation.</li>
      <li>User dashboard with favorites, recently viewed plants, and personalized suggestions.</li>
      <li>Admin panel to manage plant database, categories, and user accounts.</li>
      <li>Feedback and contact system for user interaction.</li>
      <li>Future integration of AR/VR plant visualization.</li>
    </ul>
  </div>

</div>




<script>
function toggleNav(){
  document.getElementById('navLinks').classList.toggle('show');
}
</script>

</asp:Content>

