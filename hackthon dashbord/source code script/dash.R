library(shiny)
library(shinydashboard)
library(shinyjs)
library(readxl)
library(DT)
library(plotly)
library(dplyr)
library(leaflet)

# Load dataset
RW_clean1 <- read_excel("C:/Users/GATETE Gimmy/Desktop/hackthon dashbord/DATASET/hidden hunger data.xlsx")


ui <- dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  
  dashboardBody(
    useShinyjs(),  # Initialize shinyjs
    
    # Splash Screen
    div(
      id = "splash-screen",
      style = "
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
      ",
      div(
        id = "splash-content",
        style = "
          text-align: center;
          animation: splashFadeIn 0.8s ease;
        ",
        h1(
          "🌱 THE SEED OF HOPE",
          style = "
            font-size: 48px;
            font-weight: bold;
            color: white;
            margin: 0;
            text-shadow: 0 4px 8px rgba(0,0,0,0.3);
            letter-spacing: 3px;
          "
        ),
        p(
          "END HIDDEN HUNGER IN RWANDA",
          style = "
            font-size: 20px;
            color: rgba(255,255,255,0.9);
            margin-top: 15px;
            font-style: italic;
            letter-spacing: 2px;
          "
        )
      )
    ),
    
    # Floating Chatbot Container
    div(
      id = "chatbot-container",
      div(
        id = "chatbot-bubble",
        HTML('&#128172;'),  # Chat bubble emoji
        onclick = "document.getElementById('chatbot-window').classList.toggle('show');"
      ),
      div(
        id = "chatbot-window",
        div(
          id = "chatbot-header",
          HTML("🤖 Dashboard Assistant"),
          div(
            style = "position: absolute; right: 10px; top: 10px; cursor: pointer; font-size: 18px;",
            onclick = "document.getElementById('chatbot-window').classList.remove('show');",
            "✕"
          )
        ),
        div(
          id = "chatbot-messages"
        ),
        div(
          id = "chatbot-input-area",
          textInput("chatbot_input", label = "", placeholder = "Type your question...", width = "100%"),
          actionButton("chatbot_send", "Send", width = "50px")
        )
      )
    ),
    
    # Breadcrumb Navigation
    div(
      style = "background: white; padding: 12px 40px; margin-bottom: 20px; border-bottom: 2px solid #f0f0f0;",
      p(
        HTML('<i class="fa fa-home"></i> <strong>Dashboard</strong> / <span id="current-page">HOME</span>'),
        style = "margin: 0; font-size: 14px; color: #666;"
      )
    ),
    div(
      id = "sticky-header",
      style = "
           margin-left: 40px; 
           margin-right: 40px;
           background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url('https://media.tranetechnologies.com/is/image/TraneTechnologies/Tomatoes-in-Pure-Harvest-Greenhouse:large-16-9'); 
           background-size: cover;  /* Fills entire area, may crop image edges */
           background-repeat: no-repeat;
           background-position: center;  /* Centers the image */
           padding: 40px; ",
      h1("THE SEED OF HOPE",
         style = "
       text-align: center; 
       font-weight: bold; 
       font-size: 36px; 
       color: white;
       text-shadow: 3px 3px 6px rgba(0,0,0,1), 0 0 10px rgba(0,0,0,0.9);
       letter-spacing: 2px;
     "),
      # Sub-heading (italic goal)
      h3(tags$i("END HIDDEN HUNGER IN RWANDA"),
         style = "
       text-align: center;
       font-size: 24px;
       color: white;
       margin-top: -10px;
       font-style: italic;
       text-shadow: 2px 2px 5px rgba(0,0,0,1), 0 0 8px rgba(0,0,0,0.9);
       letter-spacing: 1px;
       "
      ),
      div(
        style = "display: flex; justify-content: space-between; align-items: flex-end; position: relative; z-index: 1; margin-left:20px; margin-right:20px; margin-bottom: -52px; padding-bottom: 12px; pointer-events: none;",
        div(),  # Empty div for spacing
        div(
          style = "display: flex; gap: 12px; align-items: center; pointer-events: auto;",
          actionButton("show_about", "ℹ️", style = "background-color: #3d6ab5; color: white; border: 2px solid white; border-radius: 50%; width: 44px; height: 44px; padding: 0; font-weight: bold; font-size: 20px; cursor: pointer; transition: all 0.3s; box-shadow: 0 2px 8px rgba(61, 106, 181, 0.4);")
        )
      ),
      div(
        style = "margin-left:20px; margin-right:20px;",
        tabsetPanel(
          id = "main-tabs",
          
          # HOME tab
          tabPanel(title = tagList(icon("home"), "HOME"),
                   div(
                     style = "background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%); border-radius: 12px; padding: 15px 25px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); margin-bottom: 20px;",
                     h2("INTRODUCTION", style = "color: white; font-size:28px; margin: 0; text-shadow: 0 2px 4px rgba(0,0,0,0.3);")
                   ),
                   
                   div(
                     style = "background: rgba(255, 255, 255, 0.7); border-radius: 15px; padding: 40px; box-shadow: 0 6px 20px rgba(0,0,0,0.12); margin-bottom: 30px; border-left: 6px solid darkblue; border-top: 3px solid darkblue;",
                     p("Hidden hunger remains one of the most pressing challenges to public health 
                     and development in Rwanda. While many households have access to food, 
                     much of it lacks the vitamins and minerals necessary for healthy growth 
                     and development. This silent crisis often goes unnoticed because it does 
                     not always manifest in obvious hunger, yet its impact on children, mothers, 
                     and communities is severe and long-lasting.", 
                       style = "font-size:18px; text-align:justify; color: #333; line-height: 1.8;"),
                     br(),
                     p("The Seed of Hope initiative aims to shed light on this issue and propose 
                     sustainable solutions to fight hidden hunger through greenhouse farming, 
                     improved nutrition awareness, and community-driven strategies. 
                     This dashboard provides an overview of the problem, the current situation 
                     in Rwanda, and recommendations for action.", 
                       style = "font-size:18px; text-align:justify; color: #333; line-height: 1.8; margin-bottom: 0;")
                   ),
                   #value boxes row
                   tags$head(
                     tags$script(HTML("
          $(document).ready(function() {
            // Back to Top Button
            var scrollButton = $('<button id=\"backToTop\" title=\"Back to Top\" style=\"display:none; position:fixed; bottom:30px; right:30px; z-index:99; border:none; background-color:darkblue; color:white; cursor:pointer; padding:12px 18px; border-radius:50%; font-size:18px; box-shadow:0 4px 12px rgba(0,0,0,0.3);\"><i class=\"fa fa-arrow-up\"></i></button>');
            $('body').append(scrollButton);
            
            $(window).scroll(function() {
              if ($(this).scrollTop() > 300) {
                $('#backToTop').fadeIn();
              } else {
                $('#backToTop').fadeOut();
              }
            });
            
            $('#backToTop').click(function() {
              $('html, body').animate({scrollTop: 0}, 'slow');
              return false;
            });
          });
        ")),
                     tags$script(HTML("
          $(document).ready(function() {
            // Wait a bit for Shiny to render value boxes
            setTimeout(function() {
              // Hide all value boxes initially
              $('.value-box').hide();
              
              // Show boxes with delay
              $('#total_children').delay(0).fadeIn(500);
              $('#stunting_rate').delay(1000).fadeIn(500);
              $('#underweight_rate').delay(2000).fadeIn(500);
              $('#wasting_rate').delay(3000).fadeIn(500);
            }, 1000); // Wait 1 second for Shiny to render
          });
        "))
                   ),
                   fluidRow(
                     column(3, valueBoxOutput("total_children", width = 12) %>% tagAppendAttributes(class = "value-box")),
                     column(3, valueBoxOutput("stunting_rate", width = 12) %>% tagAppendAttributes(class = "value-box")),
                     column(3, valueBoxOutput("wasting_rate", width = 12) %>% tagAppendAttributes(class = "value-box")),
                     column(3, valueBoxOutput("underweight_rate", width = 12) %>% tagAppendAttributes(class = "value-box"))
                   ),
                   div(
                     style = "max-height:500px; overflow-y:auto; padding-right:10px;",
                     fluidRow(
                       column(4,
                              box(
                                title = tagList(HTML("<span style='color: white;'>What is Hidden Hunger?</span>")), status = "primary", solidHeader = TRUE, width = 12,
                                "Hidden hunger occurs when people consume enough calories but lack essential micronutrients such as vitamins and minerals. In Rwanda,
                              it remains a major challenge, particularly affecting children and women of reproductive age.",
                                style = "font-size:18px; text-align:justify; background: rgba(255, 255, 255, 0.5);"
                              )
                       ),
                       column(4,
                              box(
                                title = tagList(HTML("<span style='color: white;'>Why It Matters?</span>")), status = "primary", solidHeader = TRUE, width = 12,
                                "Hidden hunger has long-term consequences for both individuals and society. It leads to stunted growth,
                              impaired brain development, reduced productivity, and increased vulnerability to diseases.",
                                style = "font-size:18px; text-align:justify; background: rgba(255, 255, 255, 0.5);"
                              )
                       ),
                       column(4,
                              box(
                                title = tagList(HTML("<span style='color: white;'>Our Focus!</span>")), status = "primary", solidHeader = TRUE, width = 12,
                                "The Seed of Hope initiative seeks to combat hidden hunger through greenhouse-based farming technologies,
                              nutrition awareness, maternal and child health support, and sustainable food systems.",
                                style = "font-size:18px; text-align:justify; background: rgba(255, 255, 255, 0.5);"
                              )
                       )
                     )
                   )
          ),
          
          # ANALYSIS tab
          tabPanel(title = tagList(icon("chart-bar"), "ANALYSIS"),
                   selectInput("situation_view", "Select View:", 
                               choices = c("Visualization", "Report"), 
                               selected = "Visualization",
                               width = "200px"),
                   br(),
                   conditionalPanel(
                     condition = "input.situation_view == 'Visualization'",
                     fluidRow(
                       column(9,
                              fluidRow(
                                column(12,
                                       fluidRow(
                                         column(6,
                                                box(title = "Stunting Prevalence by Area Type",
                                                    plotlyOutput("plot_stunting", height = "350px"),
                                                    br(),
                                                    fluidRow(
                                                      column(12, downloadButton("download_stunting", "Download Chart", class = "btn-sm", style = "width: 100%; background-color: #3d6ab5; color: white; border-radius: 5px;"))
                                                    ),
                                                    width = 12)
                                         ),
                                         column(6,
                                                box(title = "Underweight Prevalence by Wealth Quintile",
                                                    plotlyOutput("plot_underweight", height = "350px"),
                                                    br(),
                                                    downloadButton("download_underweight", "Download Chart", class = "btn-sm", style = "width: 100%; background-color: darkblue; color: white; border-radius: 5px;"),
                                                    width = 12)
                                         )
                                       )
                                ),
                                column(12,
                                       box(title = "Nutritional Status Distribution (Z-scores)",
                                           plotlyOutput("plot_distribution", height = "450px"),
                                           br(),
                                           downloadButton("download_distribution", "Download Chart", class = "btn-sm", style = "width: 100%; background-color: darkblue; color: white; border-radius: 5px;"),
                                           width = 12)
                                ),
                                column(12,
                                       box(title = "Wasting Prevalence by Maternal Education",
                                           plotlyOutput("plot_wasting", height = "350px"),
                                           br(),
                                           downloadButton("download_wasting", "Download Chart", class = "btn-sm", style = "width: 100%; background-color: darkblue; color: white; border-radius: 5px;"),
                                           width = 12)
                                ),
                                column(12,
                                       div(
                                         style = "background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%); border-radius: 12px; padding: 15px 25px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); margin: 20px 0;",
                                         h3("Relationships Analysis", style="color: white; font-weight:bold; margin: 0; text-shadow: 0 2px 4px rgba(0,0,0,0.3);")
                                       ),
                                       fluidRow(
                                         column(6,
                                                box(title = "Child Age vs Height-for-Age Z-score",
                                                    plotlyOutput("plot_simple_age", height = "350px"),
                                                    br(),
                                                    p("Shows how chronic malnutrition (stunting) changes as children grow older.", 
                                                      style="font-size:14px; color:gray;"),
                                                    width = 12)
                                         ),
                                         column(6,
                                                box(title = "Wealth Quintile vs Stunting Prevalence",
                                                    plotlyOutput("plot_simple_wealth", height = "350px"),
                                                    br(),
                                                    p("Compares stunting rates across different wealth levels.", 
                                                      style="font-size:14px; color:gray;"),
                                                    width = 12)
                                         )
                                       )
                                ),
                                column(12,
                                       box(title = tagList(HTML("<span style='color: white;'>Key Insights from Data Analysis</span>")),
                                           status = "primary",
                                           solidHeader = TRUE,
                                           uiOutput("simple_insights"),
                                           width = 12)
                                ),
                                column(12,
                                       hr(),
                                       div(
                                         style = "background: rgba(255, 255, 255, 0.5); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                         checkboxInput("show_data", "Show Dataset Preview", value = FALSE, width = "100%"),
                                         conditionalPanel(
                                           condition = "input.show_data == true",
                                           box(
                                             title = "Dataset Preview", status = "primary", solidHeader = TRUE, width = 12,
                                             div(style = "max-height:500px; overflow-y:auto; background: #ffffff; border-radius: 8px; padding: 10px;",
                                                 DTOutput("data_preview")
                                             ),
                                             br(),
                                             downloadButton("download_filtered", "Download Filtered Data",
                                                            style="background-color:darkblue; color:white; border-radius:8px; font-weight:bold; width: 100%;")
                                           )
                                         )
                                       )
                                )
                              )
                       ),
                       column(3,
                              div(
                                style = "background: rgba(255, 255, 255, 0.5); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); position: sticky; top: 100px; max-height: 90vh; overflow-y: auto;",
                                h4("Filters", style = "color: darkblue; font-weight: bold; margin-top: 0; margin-bottom: 15px;"),
                                div(style = "margin-bottom: 15px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; color: #666;", "Urban/Rural: 1=Urban, 2=Rural"),
                                selectInput("filter_urban_rural", "Urban/Rural:", 
                                            choices = c("All", "1", "2"), selected = "All"),
                                div(style = "margin-bottom: 15px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; color: #666;", "Child Sex: Sex of the child (Male/Female)"),
                                selectInput("filter_sex", "Child Sex:", 
                                            choices = c("All", unique(RW_clean1$child_sex)), selected = "All"),
                                div(style = "margin-bottom: 15px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; color: #666;", "Child Age: Age in months (0-59 months)"),
                                sliderInput("filter_age", "Child Age (months):", 
                                            min = min(RW_clean1$child_age_months, na.rm = TRUE),
                                            max = max(RW_clean1$child_age_months, na.rm = TRUE),
                                            value = c(min(RW_clean1$child_age_months, na.rm = TRUE),
                                                      max(RW_clean1$child_age_months, na.rm = TRUE))),
                                div(style = "margin-bottom: 15px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; color: #666;", "Maternal Education: 0=No Education, 1=Primary, 2=Secondary, 3=College/University, 8=Missing"),
                                selectInput("filter_wealth", "Wealth Index:",
                                            choices = c("All", unique(RW_clean1$wealth_index)), selected = "All"),
                                actionButton("reset_filters", "Reset Filters", icon = icon("redo"), 
                                             style="background-color:darkblue; color:white; border-radius:10px; font-weight:bold; width: 100%; margin-top: 10px;")
                              )
                       )
                     )
                   ),
                   
                   conditionalPanel(
                     condition = "input.situation_view == 'Report'",
                     fluidRow(
                       column(12,
                              box(title = "Comprehensive Analysis Report", width = 12, status = "primary", solidHeader = TRUE,
                                  uiOutput("report_summary")
                              )
                       )
                     )
                   )
          ),
          
          # RECOMMENDATION tab 
          tabPanel(title = tagList(icon("lightbulb"), "RECOMMENDATION"),
                   div(
                     style = "background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%); border-radius: 12px; padding: 15px 25px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); margin-bottom: 20px;",
                     h2("SUSTAINABLE STRATEGIES AND ACTIONS", style = "color: white; font-size:28px; margin: 0; text-shadow: 0 2px 4px rgba(0,0,0,0.3);")
                   ),
                   
                   # Right-aligned tab navigation
                   div(
                     style = "background: rgba(255, 255, 255, 0.5); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); margin-bottom: 20px;",
                     fluidRow(
                       column(12,
                              tabsetPanel(
                                id = "recommendation_tabs",
                                type = "pills",
                                
                                tabPanel("Tech Greenhouse",
                                         value = "greenhouse",
                                         icon = icon("seedling"),
                                         br(),
                                         # Added video in a 6-sized layout
                                         div(
                                           style = "background: rgba(255, 255, 255, 0.75); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                           fluidRow(
                                             column(6,
                                                    box(
                                                      title = tagList(HTML("<span style='color: white;'>Tech-Based Greenhouse Systems</span>")), 
                                                      status = "primary", 
                                                      solidHeader = TRUE, 
                                                      width = 12,
                                                      h4("Overview", style = "color:darkblue;"),
                                                      p("Implementation of affordable, IoT-powered greenhouse infrastructure to ensure year-round production of fresh, nutrient-rich vegetables and fruits, eliminating seasonal food shortages and enhancing local food security.",
                                                        style = "font-size:16px; text-align:justify;"),
                                                      h4("Key Features:", style = "color:darkblue;"),
                                                      tags$ul(
                                                        tags$li(tags$b("Smart Agriculture Technology:"), " Automated irrigation systems, soil moisture sensors, and climate control mechanisms optimized for Rwanda's topography"),
                                                        tags$li(tags$b("Digital Farm Management:"), " Real-time monitoring dashboards accessible via mobile devices for smallholder farmers"),
                                                        tags$li(tags$b("Capacity Building:"), " Training programs for youth and women in greenhouse operation and digital agriculture"),
                                                        tags$li(tags$b("Market Linkages:"), " Direct supply chains connecting greenhouses to schools, hospitals, and local markets"),
                                                        style = "font-size:16px;"
                                                      ),
                                                      h4("Integration with National Strategy:", style = "color:darkblue;"),
                                                      tags$ul(
                                                        tags$li(tags$b("School Feeding Program Supply:"), " Greenhouses serve as primary suppliers of fresh produce for free school meal initiatives, ensuring consistent nutrient availability"),
                                                        tags$li(tags$b("Employment Generation:"), " Creates sustainable jobs in rural and peri-urban areas, reducing food insecurity at household level"),
                                                        tags$li(tags$b("Food Fortification Support:"), " Produces vitamin-rich crops (leafy greens, tomatoes, peppers) that complement fortified staples"),
                                                        style = "font-size:16px;"
                                                      )
                                                    )
                                             ),
                                             column(6,
                                                    box(
                                                      title = tagList(HTML("<span style='color: white;'>Greenhouse Technology Demonstration</span>")), 
                                                      status = "info", 
                                                      solidHeader = TRUE, 
                                                      width = 12,
                                                      HTML('<div style="text-align: center;">
                                                           <iframe width="100%" height="315" 
                                                                   src="https://www.youtube.com/embed/2YJHcGQnpAk" 
                                                                   frameborder="0" 
                                                                   allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                                                   allowfullscreen>
                                                           </iframe>
                                                           <p style="font-size:14px; color:gray; margin-top:10px;">
                                                             Demonstration of IoT-powered greenhouse technology for sustainable agriculture
                                                           </p>
                                                         </div>')
                                                    )
                                             )
                                           )
                                         )
                                ),
                                
                                tabPanel("Nutrition Education",
                                         value = "nutrition",
                                         icon = icon("book"),
                                         br(),
                                         div(
                                           style = "background: rgba(255, 255, 255, 0.75); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                           box(
                                             title = tagList(HTML("<span style='color: white;'>Comprehensive Nutrition Education Program</span>")), 
                                             status = "primary", 
                                             solidHeader = TRUE, 
                                             width = 12,
                                             h4("Overview", style = "color:darkblue;"),
                                             p("A multi-channel education initiative designed to transform nutritional knowledge and behavior across all demographic groups, from expectant mothers to school children and community leaders.",
                                               style = "font-size:16px; text-align:justify;"),
                                             hr(),
                                             h4("A. School-Based Nutrition Curriculum", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Integration of nutrition education into primary and secondary school programs"),
                                               tags$li("Practical cooking demonstrations using locally available, nutrient-rich foods"),
                                               tags$li("Student nutrition ambassadors program to extend learning to households"),
                                               tags$li("Meal Quality Monitoring: Regular assessment of school meals to verify nutritional adequacy and introduce improvements"),
                                               style = "font-size:16px;"
                                             ),
                                             h4("B. Community Outreach Programs", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Village-level workshops on balanced diets, micronutrient importance, and affordable nutrition solutions"),
                                               tags$li("Radio programs and SMS campaigns in Kinyarwanda reaching remote areas"),
                                               tags$li("Interactive demonstrations at health centers and community gathering spaces"),
                                               tags$li("Food Waste Education: Training on proper food storage, understanding expiration dates, and creative use of leftovers"),
                                               style = "font-size:16px;"
                                             ),
                                             h4("C. Public Awareness Campaigns", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Mass media campaigns highlighting the dangers of hidden hunger and stunting"),
                                               tags$li("Social media engagement targeting urban youth and middle-class families"),
                                               tags$li("Fortified Food Education:Public information campaigns explaining benefits of fortified flour, oil, and salt"),
                                               tags$li("Celebrity and influencer partnerships to normalize nutrition-conscious behaviors"),
                                               style = "font-size:16px;"
                                             ),
                                             h4("D. Resettlement Area Support", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Nutrition counseling services integrated into housing support programs"),
                                               tags$li("Cooking classes adapted to available resources in transitional housing"),
                                               tags$li("Urban garden training for families in resettlement communities"),
                                               style = "font-size:16px;"
                                             )
                                           )
                                         )
                                ),
                                
                                tabPanel("Maternal & Child Health",
                                         value = "health",
                                         icon = icon("heartbeat"),
                                         br(),
                                         div(
                                           style = "background: rgba(255, 255, 255, 0.75); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                           box(
                                             title = tagList(HTML("<span style='color: white;'>Maternal and Child Health Enhancement</span>")), 
                                             status = "primary", 
                                             solidHeader = TRUE, 
                                             width = 12,
                                             h4("Overview", style = "color:darkblue;"),
                                             p("Strengthened prenatal, postnatal, and early childhood nutrition programs ensuring the first 1,000 days of life receive optimal nutritional support for lifelong health outcomes.",
                                               style = "font-size:16px; text-align:justify;"),
                                             hr(),
                                             h4("A. Prenatal and Postnatal Care", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Enhanced antenatal clinic services with mandatory nutrition screening and counseling"),
                                               tags$li("Distribution of prenatal vitamins (iron, folic acid, calcium) to all pregnant women"),
                                               tags$li("Breastfeeding support groups and lactation counseling at community health centers"),
                                               tags$li("Micronutrient supplementation for nursing mothers"),
                                               style = "font-size:16px;"
                                             ),
                                             h4("B. Child Nutrition Monitoring", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Growth monitoring and promotion (GMP) at all health facilities"),
                                               tags$li("Timely introduction of complementary feeding with locally produced, nutrient-dense foods"),
                                               tags$li("Vitamin A supplementation and deworming campaigns twice yearly"),
                                               tags$li("Early detection and treatment of acute malnutrition"),
                                               style = "font-size:16px;"
                                             ),
                                             h4("C. Integration with Social Protection", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Free School Meal Program:Daily provision of balanced, micronutrient-rich meals to all children in public primary schools"),
                                               tags$li("Menu designed by nutritionists to meet 40% of daily nutrient requirements"),
                                               tags$li("Locally sourced ingredients from tech-based greenhouses and cooperatives"),
                                               tags$li("IoT-based meal quality tracking system ensuring consistency"),
                                               tags$li("Regular health screenings to measure program impact on stunting and anemia rates"),
                                               style = "font-size:16px;"
                                             ),
                                             h4("D. Housing Security and Nutrition Linkage", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Housing First Initiative:Provision of stable, affordable housing to vulnerable families"),
                                               tags$li("Rental assistance and transitional housing for homeless families"),
                                               tags$li("Urban gardens in resettlement areas providing fresh produce access"),
                                               tags$li("Nutrition counseling integrated into housing support services"),
                                               tags$li("Community kitchens in housing cooperatives for shared meal preparation"),
                                               style = "font-size:16px;"
                                             )
                                           )
                                         )
                                ),
                                
                                tabPanel("School Meals",
                                         value = "schoolmeals",
                                         icon = icon("utensils"),
                                         br(),
                                         div(
                                           style = "background: rgba(255, 255, 255, 0.75); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                           box(
                                             title = tagList(HTML("<span style='color: white;'>Free School Meal Program</span>")), 
                                             status = "primary", 
                                             solidHeader = TRUE, 
                                             width = 12,
                                             h4("Overview", style = "color:darkblue;"),
                                             p("Daily provision of balanced, micronutrient-rich meals to all children in public primary schools, with meals designed by nutritionists to meet 40% of daily nutrient requirements.",
                                               style = "font-size:16px; text-align:justify;"),
                                             hr(),
                                             h4("Program Features:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Nutritionist-designed menus meeting 40% of daily dietary needs"),
                                               tags$li("Locally sourced ingredients from tech-based greenhouses and cooperatives"),
                                               tags$li("IoT-based meal quality tracking system ensuring nutritional consistency"),
                                               tags$li("Regular health screenings to measure impact on stunting and anemia"),
                                               tags$li("Surplus food redirection to vulnerable households through redistribution systems"),
                                               style = "font-size:16px;"
                                             ),
                                             hr(),
                                             h4("Expected Impact:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Improved concentration and learning outcomes in students"),
                                               tags$li("Boosted school attendance rates"),
                                               tags$li("Reduced malnutrition among children in poor families"),
                                               tags$li("Local demand supporting farmer income and greenhouse sustainability"),
                                               style = "font-size:16px;"
                                             )
                                           )
                                         )
                                ),
                                
                                tabPanel("Housing Aid",
                                         value = "housing",
                                         icon = icon("home"),
                                         br(),
                                         div(
                                           style = "background: rgba(255, 255, 255, 0.75); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                           box(
                                             title = tagList(HTML("<span style='color: white;'>Housing Security and Nutrition Linkage</span>")), 
                                             status = "primary", 
                                             solidHeader = TRUE, 
                                             width = 12,
                                             h4("Overview", style = "color:darkblue;"),
                                             p("Housing First Initiative providing stable, affordable housing to vulnerable families, recognizing that housing security is foundational to food security.",
                                               style = "font-size:16px; text-align:justify;"),
                                             hr(),
                                             h4("Key Strategies:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Rental assistance and transitional housing for homeless families"),
                                               tags$li("Urban gardens in resettlement areas providing fresh produce access"),
                                               tags$li("Nutrition counseling integrated into housing support services"),
                                               tags$li("Community kitchens in housing cooperatives for shared meal preparation"),
                                               tags$li("Housing cooperatives identifying and assisting at-risk families"),
                                               style = "font-size:16px;"
                                             ),
                                             hr(),
                                             h4("Expected Impact:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Reduced hunger among homeless and vulnerable households"),
                                               tags$li("Stable housing enabling better access to food programs"),
                                               tags$li("Improved access to health and nutrition services"),
                                               tags$li("Financial burden reduction enabling families to afford better nutrition"),
                                               style = "font-size:16px;"
                                             )
                                           )
                                         )
                                ),
                                
                                tabPanel("Food Waste & Fortification",
                                         value = "waste",
                                         icon = icon("recycle"),
                                         br(),
                                         div(
                                           style = "background: rgba(255, 255, 255, 0.75); border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);",
                                           box(
                                             title = tagList(HTML("<span style='color: white;'>Food Waste Reduction and National Food Fortification</span>")), 
                                             status = "primary", 
                                             solidHeader = TRUE, 
                                             width = 12,
                                             h4("Food Waste Reduction and Redistribution System", style = "color:darkblue;"),
                                             p("A technology-enabled platform connecting food surplus from markets, restaurants, hotels, and households to charitable organizations, schools, and vulnerable populations.",
                                               style = "font-size:16px; text-align:justify;"),
                                             tags$ul(
                                               tags$li("Expiration Date Literacy:Teaching difference between 'best before' and 'use by' dates"),
                                               tags$li("Creative Leftover Utilization: Recipes and techniques for repurposing food scraps"),
                                               tags$li("Home composting programs for non-edible food waste"),
                                               tags$li("School programs teaching children about food waste impact"),
                                               tags$li("Collection systems at schools, hospitals, and government institutions"),
                                               tags$li("Tax incentives for businesses participating in food donation programs"),
                                               style = "font-size:16px;"
                                             ),
                                             hr(),
                                             h4("National Food Fortification Program", style = "color:darkblue;"),
                                             p("Population-level intervention ensuring all Rwandans access essential micronutrients through fortification of staple foods consumed daily.",
                                               style = "font-size:16px; text-align:justify;"),
                                             h5("Mandatory Fortification Standards:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Wheat and maize flour:Fortification with iron, folic acid, vitamin B12, zinc"),
                                               tags$li("Cooking oil: Vitamin A and D fortification"),
                                               tags$li("Salt:Iodization to prevent iodine deficiency disorders"),
                                               tags$li("Regulatory enforcement through Rwanda Standards Board (RSB)"),
                                               style = "font-size:16px;"
                                             ),
                                             h5("Quality Assurance System:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Laboratory testing at production facilities and market surveillance"),
                                               tags$li("IoT-enabled monitoring of fortification levels in real-time"),
                                               tags$li("Public reporting dashboard showing compliance rates by manufacturer"),
                                               tags$li("Penalties for non-compliance and rewards for excellence"),
                                               style = "font-size:16px;"
                                             ),
                                             h5("Supply Chain Integration:", style = "color:darkblue;"),
                                             tags$ul(
                                               tags$li("Fortified flour prioritized for school meal programs"),
                                               tags$li("Healthcare facilities using fortified foods in therapeutic feeding"),
                                               tags$li("Subsidies for fortified products accessed by low-income households"),
                                               style = "font-size:16px;"
                                             )
                                           )
                                         )
                                )
                              )
                       )
                     )
                   )
          )
        ),
        
        # Footer Section
        div(
          style = "background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%); color: white; padding: 30px; margin-top: 40px; border-top: 4px solid #3d6ab5; text-align: center;",
          fluidRow(
            column(4,
                   h4("Project Information", style = "color: white; font-weight: bold; margin-top: 0;"),
                   p("The Seed of Hope", style = "font-size: 16px; margin-bottom: 5px; color: white;"),
                   p("Ending Hidden Hunger in Rwanda", style = "font-size: 14px; font-style: italic; color: #e0e0e0; margin: 0;")
            ),
            column(4,
                   h4("Developer", style = "color: white; font-weight: bold; margin-top: 0;"),
                   p("MUGISHA GATETE GIMMY", style = "font-size: 16px; margin-bottom: 5px; color: white;"),
                   p("Data Analyst & Dashboard Developer", style = "font-size: 14px; color: #e0e0e0; margin: 0;")
            ),
            column(4,
                   h4("Contact & Resources", style = "color: white; font-weight: bold; margin-top: 0;"),
                   p("Email: gatetegimmy5@gmail.com", style = "font-size: 14px; margin-bottom: 5px; color: white;"),
                   p("Phone: +250 784 439 220", style = "font-size: 14px; color: #e0e0e0; margin: 0;")
            )
          ),
          hr(style = "border-color: rgba(255,255,255,0.3); margin: 20px 0;"),
          fluidRow(
            column(6,
                   p("Data Source: Rwanda Demographic and Health Survey (RDHS) 2023", 
                     style = "font-size: 12px; color: white; margin: 5px 0;"),
                   p("Last Updated: November 2025", 
                     style = "font-size: 12px; color: white; margin: 5px 0;")
            ),
            column(6,
                   p("© 2025 The Seed of Hope Initiative. All rights reserved.", 
                     style = "font-size: 12px; color: white; margin: 5px 0; text-align: right;"),
                   p("Dashboard v1.0 | Data Quality: High", 
                     style = "font-size: 12px; color: white; margin: 5px 0; text-align: right;")
            )
          ),
          div(
            style = "text-align: center; padding-top: 15px;",
            actionButton("footer_help", "💬 Need Help?", style = "background-color: #FFD700; color: darkblue; border: 2px solid white; border-radius: 25px; padding: 8px 20px; font-weight: bold; font-size: 13px; cursor: pointer; transition: all 0.3s;")
          )
        )
      ),
      
      # About Modal
      div(
        id = "about-modal",
        div(
          class = "about-modal-content",
          div(
            class = "modal-header",
            h2("ℹ️ About This Dashboard"),
            actionButton("close_about_modal", "✕", style = "background: none; border: none; font-size: 24px; color: darkblue; font-weight: bold; cursor: pointer;")
          ),
          h3("The Seed of Hope Dashboard", style = "color: darkblue;"),
          p("A comprehensive data analysis tool for understanding and addressing hidden hunger in Rwanda.", style = "font-size: 14px; line-height: 1.8;"),
          
          h4("Project Overview", style = "color: darkblue; margin-top: 20px;"),
          p("This dashboard analyzes nutritional data from the Rwanda Demographic and Health Survey (RDHS) 2023, focusing on three key malnutrition indicators: stunting, underweight, and wasting among children under 5 years old.", style = "font-size: 14px; line-height: 1.8;"),
          
          h4("Dashboard Features", style = "color: darkblue; margin-top: 20px;"),
          tags$ul(
            tags$li("Interactive visualizations of malnutrition prevalence"),
            tags$li("Advanced filtering by location, demographics, and wealth index"),
            tags$li("Downloadable charts and data exports"),
            tags$li("Evidence-based insights and policy recommendations"),
            tags$li("Real-time data analysis and reporting"),
            style = "font-size: 14px; line-height: 2;"
          ),
          
          h4("Developer", style = "color: darkblue; margin-top: 20px;"),
          p("Created by: MUGISHA GATETE GIMMY", style = "font-size: 14px; font-weight: bold;"),
          p("Role: Data Analyst & Dashboard Developer", style = "font-size: 13px; color: #666;"),
          p("Email: gatetegimmy5@gmail.com", style = "font-size: 13px;"),
          p("Phone: +250 784 439 220", style = "font-size: 13px;"),
          
          h4("Technical Stack", style = "color: darkblue; margin-top: 20px;"),
          p("Built with R Shiny | Data: RDHS 2023 | Last Updated: November 2025", style = "font-size: 13px; color: #666;"),
          
          div(
            style = "margin-top: 25px; padding-top: 15px; border-top: 2px solid #e0e0e0; text-align: center;",
            p("Version 1.0 | © 2025 The Seed of Hope Initiative", style = "font-size: 12px; color: #999; margin: 0;")
          )
        )
      ),
      
      tags$head(
        tags$style(HTML("
          .content-wrapper, .right-side {background-color: #f0f0f0;}
          #sticky-header {
            position: sticky;
            top: 0;
            z-index: 999;
            background-color: #ffffff;
            padding: 10px;
            border-bottom: 2px solid darkblue;
          }
          .nav.nav-tabs {
            display: flex;
            justify-content: flex-start;
            border-bottom: none;
            margin-top: 10px;
            background-color: transparent;
          }
          .nav-tabs > li > a {
            font-weight: bold;
            font-size: 18px;
            color: darkblue;
            background-color: white;
            border: 2px solid darkblue;
            border-radius: 12px;
            padding: 12px 20px;
            margin-right: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
          }
          .nav-tabs > li > a:hover {
            background-color: #f0f0f0;
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
            transform: translateY(-2px);
          }
          .nav-tabs > li.active > a {
            background-color: darkblue !important;
            color: white !important;
            border-color: darkblue !important;
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
          }
          
          /* Style for recommendation pills */
          #recommendation_tabs {
            width: 100%;
          }
        #recommendation_tabs .nav-pills {
          display: flex;
          justify-content: flex-start;
          flex-wrap: wrap;
          gap: 10px;
          padding-bottom: 10px;
        }
        #recommendation_tabs .nav-pills > li > a {
          background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%);
          color: white;
          border: none;
          border-radius: 12px;
          padding: 12px 16px;
          font-weight: bold;
          font-size: 12px;
          transition: all 0.3s ease;
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
          text-shadow: 0 1px 2px rgba(0,0,0,0.3);
          white-space: nowrap;
          flex-shrink: 0;
        }
        #recommendation_tabs .nav-pills > li > a:hover {
          background: linear-gradient(135deg, #5a8dd4 0%, #6fa1e0 100%);
          transform: translateY(-3px);
          box-shadow: 0 6px 16px rgba(0,0,0,0.25);
        }
        #recommendation_tabs .nav-pills > li.active > a {
          background: linear-gradient(135deg, #0d47a1 0%, #0d1f47 100%) !important;
          color: white !important;
          box-shadow: 0 6px 20px rgba(0,0,0,0.35);
          transform: translateY(-2px);
        }          .box {border-radius: 10px; font-size: 18px; background-color: rgba(255, 255, 255, 0.6);}
          .box .box-title {font-size: 24px; font-weight: bold; color: #3d6ab5; text-shadow: 0 1px 2px rgba(0,0,0,0.1); letter-spacing: 0.5px;}
          .box-body {font-size: 16px; line-height: 1.6; color: #333;}
          
          /* Value box styling */
          .small-box {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
          }
          .small-box h3 {
            font-size: 28px !important;
            font-weight: bold;
            color: white;
          }
          .small-box .small-box-footer {
            font-size: 15px;
            font-weight: bold;
          }
          .small-box .icon {
            font-size: 50px;
            opacity: 0.8;
          }
          
          /* Overall text improvements */
          body {font-family: 'Arial', sans-serif; color: #333; overflow-x: hidden; width: 100%; max-width: 100vw;}
          html {width: 100%; max-width: 100vw; overflow-x: hidden;}
          .content-wrapper {overflow-x: hidden; max-width: 100%;}
          .main-content {overflow-x: hidden; max-width: 100%;}
          .shiny-input-container {max-width: 100%;}
          .tab-content {overflow-x: auto; overflow-y: visible; max-width: 100%;}
          .nav-tabs-custom {max-width: 100%;}
          .row {margin-left: 0; margin-right: 0; width: 100%;}
          
          /* Plotly chart scrolling */
          .plotly-container {overflow: visible !important; max-width: 100%;}
          .shiny-plot-output {overflow-y: auto; max-height: 600px; padding: 10px;}
          .svg-container {overflow: visible !important;}
          h1, h2, h3, h4, h5, h6 {color: #3d6ab5; font-weight: bold;}
          p {font-size: 16px; line-height: 1.6; color: #333;}
          li {font-size: 16px; line-height: 1.6; color: #333; margin-bottom: 8px;}
          a {color: #3d6ab5; font-weight: bold;}
          
          /* Chatbot Styles - UPDATED FOR BETTER SCROLLING */
          #chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            font-family: Arial, sans-serif;
          }
          
          #chatbot-bubble {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            color: white;
            font-size: 24px;
          }
          
          #chatbot-bubble:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(0,0,0,0.4);
          }
          
          #chatbot-window {
            width: 380px;
            height: 550px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
            display: none;
            flex-direction: column;
            position: absolute;
            bottom: 80px;
            right: 0;
            overflow: hidden;
            border: 1px solid #ddd;
          }
          
          #chatbot-window.show {
            display: flex;
          }
          
          #chatbot-header {
            background: linear-gradient(135deg, #3d6ab5 0%, #5a8dd4 100%);
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
            font-size: 16px;
            flex-shrink: 0;
            position: relative;
          }
          
          #chatbot-messages {
            flex: 1;
            overflow-y: auto;
            overflow-x: hidden;
            padding: 15px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            word-wrap: break-word;
            word-break: break-word;
            min-height: 0;
            max-height: 400px;
          }
          
          #chatbot-messages::-webkit-scrollbar {
            width: 8px;
          }
          
          #chatbot-messages::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
          }
          
          #chatbot-messages::-webkit-scrollbar-thumb {
            background: darkblue;
            border-radius: 10px;
          }
          
          #chatbot-messages::-webkit-scrollbar-thumb:hover {
            background: #1a3a7a;
          }
          
          .chat-message {
            padding: 10px 12px;
            border-radius: 10px;
            max-width: 85%;
            word-wrap: break-word;
            overflow-wrap: break-word;
            white-space: pre-wrap;
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 5px;
          }
          
          .bot-message {
            background: #e8f4f8;
            color: #333;
            align-self: flex-start;
            border: 1px solid #c0e0f0;
          }
          
          .user-message {
            background: #3d6ab5;
            color: white;
            align-self: flex-end;
          }
          
          #chatbot-input-area {
            padding: 12px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            gap: 8px;
            flex-shrink: 0;
            background: #f9f9f9;
          }
          
          #chatbot_input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #c0c0c0;
            border-radius: 8px;
            font-size: 13px;
            font-family: Arial, sans-serif;
          }
          
          #chatbot-send {
            padding: 8px 16px;
            background: #3d6ab5;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
          }
          
          #chatbot-send:hover {
            background: #5a8dd4;
          }
          
          /* Auto-scroll to bottom functionality */
          .chat-auto-scroll {
            overflow-anchor: auto;
          }
          
          /* Guided Tour Styles */
          .tour-highlight {
            position: relative;
            z-index: 999;
          }
          
          .tour-tooltip {
            position: absolute;
            background: darkblue;
            color: white;
            padding: 15px;
            border-radius: 10px;
            font-size: 13px;
            z-index: 1001;
            max-width: 250px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            line-height: 1.5;
          }
          
          .tour-tooltip::after {
            content: '';
            position: absolute;
            width: 10px;
            height: 10px;
            background: darkblue;
            transform: rotate(45deg);
          }
          
          /* About Modal Styles */
          #about-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
            display: none;
            z-index: 2000;
            align-items: center;
            justify-content: center;
          }
          
          #about-modal.show {
            display: flex;
          }
          
          .about-modal-content {
            background: white;
            border-radius: 15px;
            padding: 30px;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            animation: slideIn 0.3s ease;
          }
          
          @keyframes slideIn {
            from {
              transform: translateY(-50px);
              opacity: 0;
            }
            to {
              transform: translateY(0);
              opacity: 1;
            }
          }
          
          .modal-header {
            border-bottom: 3px solid darkblue;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }
          
          .modal-header h2 {
            color: darkblue;
            margin: 0;
            font-size: 28px;
          }
          
          .close-modal {
            background: none;
            border: none;
            font-size: 28px;
            cursor: pointer;
            color: darkblue;
            font-weight: bold;
          }
          
          .close-modal:hover {
            opacity: 0.7;
          }
          
          /* Splash Screen Animations */
          @keyframes splashFadeIn {
            from {
              opacity: 0;
            }
            to {
              opacity: 1;
            }
          }
          
          @keyframes splashFadeOut {
            from {
              opacity: 1;
            }
            to {
              opacity: 0;
            }
          }
          
          @keyframes moveToTop {
            from {
              transform: scale(1.2) translateY(0);
              font-size: 48px;
            }
            to {
              transform: scale(1) translateY(-250px);
              font-size: 36px;
            }
          }
          
          #splash-screen.fade-out {
            animation: splashFadeOut 1s ease forwards;
          }
          
          #splash-content.move-to-top {
            animation: moveToTop 1s ease forwards;
          }
        "))
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Splash Screen Animation (3 seconds)
  observe({
    shinyjs::runjs("
      setTimeout(function() {
        // Add animation classes
        var splashScreen = document.getElementById('splash-screen');
        var splashContent = document.getElementById('splash-content');
        
        if (splashScreen && splashContent) {
          splashContent.classList.add('move-to-top');
          splashScreen.classList.add('fade-out');
          
          // Remove splash screen after animation
          setTimeout(function() {
            splashScreen.style.display = 'none';
          }, 1000);
        }
      }, 3000); // 3 seconds delay
    ")
  })
  
  # Chatbot logic with enhanced visualization interpretation
  chatbot_responses <- list(
    hello = "🤖 Hi! I'm your Dashboard Assistant with AI-powered chart interpretation. I can help you with:\n\n📍 HOME - Overview & Statistics\n📊 ANALYSIS - Charts & Interactive Insights\n💡 RECOMMENDATION - Solutions\n📥 DOWNLOAD - Export data\n🎯 TOUR - Guided walkthrough\n\nTry asking: 'stunting chart', 'wealth comparison', 'analysis', or 'help'!",
    home = "The HOME tab shows the main overview of hidden hunger in Rwanda with key statistics and feature descriptions.",
    analysis = "The ANALYSIS tab contains interactive visualizations and reports. You can filter data by area, child sex, age, and wealth index. Use the filters on the right side!",
    filters = "📊 FILTERS: Located on the right side of the ANALYSIS tab. Filter by Urban/Rural area, Child Sex, Age (months), and Wealth Index. Click 'Reset Filters' to start over.",
    visualization = "📈 VISUALIZATION: Shows 6 interactive charts analyzing stunting, underweight, wasting, and nutritional status. Hover over charts for details. Try asking about specific charts like 'stunting chart' or 'wealth distribution'!",
    report = "📄 REPORT: Provides a comprehensive analysis summary with statistics and interpretation of the hidden hunger data.",
    recommendation = "💡 RECOMMENDATION tab shows solutions in 6 categories: Tech Greenhouse, Nutrition Education, Maternal & Child Health, School Meals, Housing Aid, and Food Waste.",
    download = "📥 You can download individual charts from the ANALYSIS tab or download filtered data using the 'Download Filtered Data' button.",
    charts = "📊 All charts are interactive! Hover for details, click legend items to show/hide data, and use the download button below each chart.",
    data = "✅ Check 'Show Dataset Preview' in the ANALYSIS tab to view the raw data behind the charts and download filtered datasets.",
    help = "🆘 I can now help you with:\n\n📊 CHART INTERPRETATION:\n• 'stunting chart' - Explains stunting by urban/rural\n• 'underweight chart' - Wealth quintile analysis\n• 'wasting chart' - Maternal education impact\n• 'z-score distribution' - Nutritional status overview\n• 'age trends' - How stunting changes with age\n• 'wealth impact' - Socioeconomic disparities\n\nOther topics: 'home', 'analysis', 'filters', 'tour'",
    tour = "🎯 Let me guide you: Start at HOME tab to see overview, then go to ANALYSIS for data exploration, and RECOMMENDATION for solutions!",
    default = "I'm not sure about that. Try asking about specific charts like: 'stunting chart', 'wealth comparison', 'age trends', 'wasting analysis', 'zone distribution', or type 'help' for more options."
  )
  
  # Function to generate chart interpretations
  generate_chart_interpretation <- function(chart_type, filtered_data_df) {
    tryCatch({
      if (grepl("stunting|area", chart_type, ignore.case = TRUE)) {
        df <- filtered_data_df %>% 
          group_by(urban_rural) %>%
          summarize(stunting_rate = mean(stunted_status == "Yes", na.rm = TRUE) * 100, count = n(), .groups = 'drop')
        
        if (nrow(df) > 0) {
          urban_rate <- df$stunting_rate[df$urban_rural == "Urban"]
          rural_rate <- df$stunting_rate[df$urban_rural == "Rural"]
          
          interpretation <- paste0(
            "📊 STUNTING PREVALENCE BY AREA:\n\n",
            "🏙️ Urban Areas: ", round(ifelse(length(urban_rate) > 0, urban_rate, 0), 1), "%\n",
            "🌾 Rural Areas: ", round(ifelse(length(rural_rate) > 0, rural_rate, 0), 1), "%\n\n",
            "💡 KEY INSIGHT: ",
            if (length(rural_rate) > 0 && length(urban_rate) > 0) {
              if (rural_rate > urban_rate) {
                paste0("Rural areas have ", round(rural_rate - urban_rate, 1), 
                       "% higher stunting rates, indicating rural children face greater malnutrition challenges.")
              } else {
                paste0("Urban areas have ", round(urban_rate - rural_rate, 1), 
                       "% higher stunting rates, suggesting urban poverty impacts nutrition significantly.")
              }
            } else {
              "Limited data for comparison."
            }
          )
          return(interpretation)
        }
      } else if (grepl("underweight|wealth", chart_type, ignore.case = TRUE)) {
        df <- filtered_data_df %>% 
          group_by(wealth_index) %>%
          summarize(underweight_rate = mean(underweight_status == "Yes", na.rm = TRUE) * 100, count = n(), .groups = 'drop') %>%
          arrange(wealth_index)
        
        if (nrow(df) > 0) {
          poorest <- df$underweight_rate[df$wealth_index == 1]
          richest <- df$underweight_rate[df$wealth_index == 5]
          
          interpretation <- paste0(
            "📊 UNDERWEIGHT PREVALENCE BY WEALTH QUINTILE:\n\n",
            "Poorest Quintile (Q1): ", round(ifelse(length(poorest) > 0, poorest, 0), 1), "%\n",
            "Richest Quintile (Q5): ", round(ifelse(length(richest) > 0, richest, 0), 1), "%\n\n",
            "💡 KEY INSIGHT: ",
            if (length(richest) > 0 && length(poorest) > 0) {
              wealth_diff <- poorest - richest
              paste0("There's a ", round(wealth_diff, 1), 
                     "% gap showing wealth strongly determines child nutrition. Poorest families face MUCH higher underweight rates.")
            } else {
              "Strong socioeconomic gradient in nutrition."
            }
          )
          return(interpretation)
        }
      } else if (grepl("wasting|maternal|education", chart_type, ignore.case = TRUE)) {
        df <- filtered_data_df %>% 
          group_by(hh_education) %>%
          summarize(wasting_rate = mean(wasted_status == "Yes", na.rm = TRUE) * 100, count = n(), .groups = 'drop') %>%
          arrange(hh_education)
        
        if (nrow(df) > 0) {
          no_edu <- df$wasting_rate[df$hh_education == 0]
          college_edu <- df$wasting_rate[df$hh_education == 3]
          
          interpretation <- paste0(
            "📊 WASTING PREVALENCE BY MATERNAL EDUCATION:\n\n",
            "No Education: ", round(ifelse(length(no_edu) > 0, no_edu, 0), 1), "%\n",
            "College/University: ", round(ifelse(length(college_edu) > 0, college_edu, 0), 1), "%\n\n",
            "💡 KEY INSIGHT: ",
            if (length(college_edu) > 0 && length(no_edu) > 0) {
              edu_diff <- no_edu - college_edu
              paste0("Mothers with higher education reduce child wasting by ", round(edu_diff, 1), 
                     "%. Education is CRUCIAL for proper nutrition and childcare practices.")
            } else {
              "Maternal education strongly influences child nutrition outcomes."
            }
          )
          return(interpretation)
        }
      } else if (grepl("z-score|distribution|nutritional status", chart_type, ignore.case = TRUE)) {
        haz_mean <- mean(filtered_data_df$HAZ, na.rm = TRUE)
        waz_mean <- mean(filtered_data_df$WAZ, na.rm = TRUE)
        whz_mean <- mean(filtered_data_df$WHZ, na.rm = TRUE)
        
        interpretation <- paste0(
          "📊 NUTRITIONAL STATUS DISTRIBUTION (Z-SCORES):\n\n",
          "Height-for-Age (HAZ): ", round(haz_mean, 2), " (Chronic stunting indicator)\n",
          "Weight-for-Age (WAZ): ", round(waz_mean, 2), " (Overall undernutrition)\n",
          "Weight-for-Height (WHZ): ", round(whz_mean, 2), " (Acute malnutrition)\n\n",
          "💡 INTERPRETATION:\n",
          "⚠️ All scores are NEGATIVE (below -2 threshold is concerning):\n",
          "• HAZ < -2 = Stunting (chronic malnutrition)\n",
          "• WAZ < -2 = Underweight (overall undernutrition)\n",
          "• WHZ < -2 = Wasting (acute malnutrition)\n\n",
          "This data shows systemic nutritional challenges affecting children's growth and development."
        )
        return(interpretation)
      } else if (grepl("age|trend|growth", chart_type, ignore.case = TRUE)) {
        df <- filtered_data_df %>% 
          filter(!is.na(HAZ) & !is.na(child_age_months)) %>%
          mutate(age_group = cut(child_age_months, 
                                 breaks = c(0, 12, 24, 36, 48, 60),
                                 labels = c("0-12m", "13-24m", "25-36m", "37-48m", "49-60m"))) %>%
          group_by(age_group) %>%
          summarize(avg_HAZ = mean(HAZ, na.rm = TRUE), .groups = 'drop')
        
        if (nrow(df) > 0) {
          youngest <- df$avg_HAZ[1]
          oldest <- df$avg_HAZ[nrow(df)]
          
          interpretation <- paste0(
            "📊 STUNTING TRENDS ACROSS CHILD AGE:\n\n",
            "Youngest (0-12 months): ", round(youngest, 2), " HAZ\n",
            "Oldest (49-60 months): ", round(oldest, 2), " HAZ\n\n",
            "💡 KEY INSIGHT: ",
            if (oldest < youngest) {
              "HAZ scores DECLINE with age, indicating cumulative malnutrition damage. "
            } else {
              "HAZ scores improve slightly with age. "
            },
            "This is the CRITICAL WINDOW: Ages 0-24 months show greatest nutritional vulnerability. "
          )
          return(interpretation)
        }
      }
      
      return("📊 Unable to generate interpretation for this chart. Try asking about: 'stunting chart', 'wealth comparison', 'wasting chart', 'z-score distribution', or 'age trends'.")
    }, error = function(e) {
      return("📊 Chart interpretation in progress. Try asking about specific visualizations!")
    })
  }
  
  # Store chat history
  chat_history <- reactiveVal(list(
    list(role = "bot", text = chatbot_responses$hello, time = Sys.time())
  ))
  
  # Chatbot response function with visualization interpretation
  get_chatbot_response <- function(user_input, data_context = NULL) {
    user_input_lower <- tolower(trimws(user_input))
    
    # Check for chart-specific questions
    if (grepl("stunting.*chart|explain.*stunting|tell.*stunting", user_input_lower)) {
      return(generate_chart_interpretation("stunting", data_context %||% RW_clean1))
    }
    if (grepl("underweight.*chart|wealth|explain.*wealth|wealth.*quintile", user_input_lower)) {
      return(generate_chart_interpretation("underweight", data_context %||% RW_clean1))
    }
    if (grepl("wasting.*chart|maternal|education|explain.*wasting", user_input_lower)) {
      return(generate_chart_interpretation("wasting", data_context %||% RW_clean1))
    }
    if (grepl("z-score|distribution|nutritional.*status|explain.*z", user_input_lower)) {
      return(generate_chart_interpretation("z-score", data_context %||% RW_clean1))
    }
    if (grepl("age.*trend|age.*growth|how.*age|age.*pattern|child.*age", user_input_lower)) {
      return(generate_chart_interpretation("age", data_context %||% RW_clean1))
    }
    if (grepl("wealth.*impact|socioeconomic|poverty|income", user_input_lower)) {
      return(generate_chart_interpretation("wealth", data_context %||% RW_clean1))
    }
    
    # Default responses
    if (grepl("hello|hi|hey|halo", user_input_lower)) return(chatbot_responses$hello)
    if (grepl("home", user_input_lower)) return(chatbot_responses$home)
    if (grepl("analysis|analyze", user_input_lower)) return(chatbot_responses$analysis)
    if (grepl("filter", user_input_lower)) return(chatbot_responses$filters)
    if (grepl("visual|chart|plot|graph", user_input_lower)) return(chatbot_responses$visualization)
    if (grepl("report", user_input_lower)) return(chatbot_responses$report)
    if (grepl("recommend|solution|strategy", user_input_lower)) return(chatbot_responses$recommendation)
    if (grepl("download|export|save", user_input_lower)) return(chatbot_responses$download)
    if (grepl("data|dataset|preview", user_input_lower)) return(chatbot_responses$data)
    if (grepl("tour|guide|navigate|navigation", user_input_lower)) return(chatbot_responses$tour)
    if (grepl("help|what|how", user_input_lower)) return(chatbot_responses$help)
    
    return(chatbot_responses$default)
  }
  
  # Handle chatbot send button with improved scrolling and data context
  observeEvent(input$chatbot_send, {
    user_message <- input$chatbot_input
    if (!is.null(user_message) && user_message != "") {
      # Add user message to history
      user_msg <- list(role = "user", text = user_message, time = Sys.time())
      chat_history(c(chat_history(), list(user_msg)))
      
      # Get bot response with filtered data context
      bot_response <- get_chatbot_response(user_message, filtered_data())
      bot_msg <- list(role = "bot", text = bot_response, time = Sys.time())
      chat_history(c(chat_history(), list(bot_msg)))
      
      # Check if tour was requested
      if (grepl("tour|guide", tolower(user_message))) {
        shinyjs::runjs("
          alert('🎯 GUIDED TOUR:\\n\\n' +
                '1️⃣ HOME Tab: Overview & Key Statistics\\n' +
                '2️⃣ ANALYSIS Tab: Interactive Charts & Filters\\n' +
                '   - Use right sidebar to filter data\\n' +
                '   - View visualizations and trends\\n' +
                '   - Ask the chatbot about specific charts!\\n' +
                '3️⃣ RECOMMENDATION Tab: Solutions\\n' +
                '   - 6 strategic categories\\n' +
                '   - Detailed implementation guides\\n' +
                '\\nTry asking about: stunting chart, wealth impact, age trends!')
        ")
      }
      
      # Clear input
      updateTextInput(session, "chatbot_input", value = "")
      
      # Enhanced scrolling after new message
      shinyjs::runjs("
        var chatDiv = document.getElementById('chatbot-messages');
        if (chatDiv) {
          setTimeout(function() {
            chatDiv.scrollTop = chatDiv.scrollHeight;
            var anchor = document.createElement('div');
            anchor.id = 'chat-anchor';
            anchor.style.height = '1px';
            chatDiv.appendChild(anchor);
            anchor.scrollIntoView({behavior: 'smooth'});
          }, 150);
        }
      ")
    }
  })
  
  # Update chatbot display with better scrolling
  observe({
    messages <- chat_history()
    if (length(messages) > 0) {
      message_html <- ""
      for (msg in messages) {
        class_name <- if (msg$role == "bot") "bot-message" else "user-message"
        safe_text <- gsub("`", "'", msg$text)  # Escape backticks
        message_html <- paste0(message_html, 
                               "<div class='chat-message ", class_name, "'>", 
                               safe_text, 
                               "</div>"
        )
      }
      shinyjs::html("chatbot-messages", message_html)
      
      # Enhanced auto-scroll to bottom
      shinyjs::runjs("
        var chatDiv = document.getElementById('chatbot-messages');
        if (chatDiv) {
          // Use setTimeout to ensure DOM is updated
          setTimeout(function() {
            chatDiv.scrollTop = chatDiv.scrollHeight;
            // Add a small anchor element at the bottom for better auto-scrolling
            var anchor = document.createElement('div');
            anchor.id = 'chat-anchor';
            anchor.style.height = '1px';
            chatDiv.appendChild(anchor);
            anchor.scrollIntoView({behavior: 'smooth'});
          }, 100);
        }
      ")
    }
  })
  
  # Footer help button opens chatbot
  observeEvent(input$footer_help, {
    shinyjs::runjs("document.getElementById('chatbot-window').classList.add('show');")
  })
  
  # About button opens modal
  observeEvent(input$show_about, {
    shinyjs::runjs("document.getElementById('about-modal').classList.add('show');")
  })
  
  # Close about modal button
  observeEvent(input$close_about_modal, {
    shinyjs::runjs("document.getElementById('about-modal').classList.remove('show');")
  })
  
  filtered_data <- reactive({
    df <- RW_clean1
    if(input$filter_urban_rural != "All") df <- df %>% filter(urban_rural == input$filter_urban_rural)
    if(input$filter_sex != "All") df <- df %>% filter(child_sex == input$filter_sex)
    df <- df %>% filter(child_age_months >= input$filter_age[1] & child_age_months <= input$filter_age[2])
    if(input$filter_wealth != "All") df <- df %>% filter(wealth_index == input$filter_wealth)
    df
  })
  
  # Reset filters
  observeEvent(input$reset_filters, {
    updateSelectInput(session, "filter_urban_rural", selected = "All")
    updateSelectInput(session, "filter_sex", selected = "All")
    updateSliderInput(session, "filter_age",
                      value = c(min(RW_clean1$child_age_months, na.rm = TRUE),
                                max(RW_clean1$child_age_months, na.rm = TRUE)))
    updateSelectInput(session, "filter_wealth", selected = "All")
  })
  
  # Value boxes for HOME tab
  output$total_children <- renderValueBox({
    total_count <- nrow(RW_clean1[RW_clean1$child_age_months >= 0 & RW_clean1$child_age_months <= 59, ])
    valueBox(
      value = format(total_count, big.mark = ","),
      subtitle = "total number",
      icon = icon("child"),
      color = "blue"
    )
  })
  
  output$stunting_rate <- renderValueBox({
    data <- RW_clean1[RW_clean1$child_age_months >= 0 & RW_clean1$child_age_months <= 59, ]
    rate <- round(mean(data$stunted_status == "Yes", na.rm = TRUE) * 100, 1)
    valueBox(
      value = paste0(rate, "%"),
      subtitle = "Stunting Rate",
      icon = icon("arrow-down"),
      color = ifelse(rate > 30, "red", ifelse(rate > 20, "yellow", "green"))
    )
  })
  
  output$underweight_rate <- renderValueBox({
    data <- RW_clean1[RW_clean1$child_age_months >= 0 & RW_clean1$child_age_months <= 59, ]
    rate <- round(mean(data$underweight_status == "Yes", na.rm = TRUE) * 100, 1)
    valueBox(
      value = paste0(rate, "%"),
      subtitle = "Underweight Rate", 
      icon = icon("weight"),
      color = ifelse(rate > 15, "red", ifelse(rate > 10, "yellow", "green"))
    )
  })
  
  output$wasting_rate <- renderValueBox({
    data <- RW_clean1[RW_clean1$child_age_months >= 0 & RW_clean1$child_age_months <= 59, ]
    rate <- round(mean(data$wasted_status == "Yes", na.rm = TRUE) * 100, 1)
    valueBox(
      value = paste0(rate, "%"),
      subtitle = "Wasting Rate",
      icon = icon("exclamation-triangle"),
      color = ifelse(rate > 8, "red", ifelse(rate > 5, "yellow", "green"))
    )
  })
  
  #plots
  output$plot_stunting <- renderPlotly({
    df <- filtered_data() %>% 
      group_by(urban_rural) %>%
      summarize(stunting_rate = mean(stunted_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    if(nrow(df) == 0) {
      plot_ly() %>% add_text(x = 0.5, y = 0.5, text = "No data available for selected filters", 
                             textposition = "middle center", mode = "text",
                             hoverinfo = "none") %>%
        layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    } else {
      plot_ly(df, x = ~urban_rural, y = ~stunting_rate, type = 'bar',
              marker = list(color = c('#3d6ab5', '#5a8dd4'),
                            line = list(color = 'darkgray', width = 1)),
              text = ~paste0(round(stunting_rate, 1), "%"),
              textposition = 'auto',
              hoverinfo = 'text',
              hovertext = ~paste("Area:", urban_rural, "<br>Stunting Rate:", round(stunting_rate, 1), "%")) %>%
        layout(xaxis = list(title = "Area Type (1=Urban, 2=Rural)", categoryorder = "array"),
               yaxis = list(title = "Stunting Rate (%)", range = c(0, 50)),
               showlegend = FALSE,
               font = list(family = "Arial", size = 12))
    }
  })
  
  output$plot_underweight <- renderPlotly({
    df <- filtered_data() %>% 
      group_by(wealth_index) %>%
      summarize(underweight_rate = mean(underweight_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    if(nrow(df) == 0) {
      plot_ly() %>% add_text(x = 0.5, y = 0.5, text = "No data available for selected filters", 
                             textposition = "middle center", mode = "text",
                             hoverinfo = "none") %>%
        layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    } else {
      colors <- c('#3d6ab5', '#4a78c7', '#5a8dd4', '#6a9cdc', '#7aabe4')
      plot_ly(df, x = ~wealth_index, y = ~underweight_rate, type = 'bar',
              marker = list(color = colors,
                            line = list(color = 'darkgray', width = 1)),
              text = ~paste0(round(underweight_rate, 1), "%"),
              textposition = 'auto',
              hoverinfo = 'text',
              hovertext = ~paste("Wealth Index:", wealth_index, "<br>Underweight Rate:", round(underweight_rate, 1), "%")) %>%
        layout(xaxis = list(title = "Wealth Index (Poorest to Richest)"),
               yaxis = list(title = "Underweight Rate (%)", range = c(0, 20)),
               showlegend = FALSE,
               font = list(family = "Arial", size = 12))
    }
  })
  
  output$plot_wasting <- renderPlotly({
    df <- filtered_data() %>% 
      group_by(hh_education) %>%
      summarize(wasting_rate = mean(wasted_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    if(nrow(df) == 0) {
      plot_ly() %>% add_text(x = 0.5, y = 0.5, text = "No data available for selected filters", 
                             textposition = "middle center", mode = "text",
                             hoverinfo = "none") %>%
        layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    } else {
      plot_ly(df, x = ~hh_education, y = ~wasting_rate, type = 'bar',
              marker = list(color = '#3d6ab5',
                            line = list(color = 'darkgray', width = 1)),
              text = ~paste0(round(wasting_rate, 1), "%"),
              textposition = 'auto',
              hoverinfo = 'text',
              hovertext = ~paste("Education Level: 0=None, 1=Primary, 2=Secondary, 3=College/University, 8=Missing<br>Wasting Rate:", round(wasting_rate, 1), "%")) %>%
        layout(xaxis = list(title = "Maternal Education (0=None, 1=Primary, 2=Secondary, 3=College/University, 8=Missing)"),
               yaxis = list(title = "Wasting Rate (%)", range = c(0, 20)),
               showlegend = FALSE,
               font = list(family = "Arial", size = 12))
    }
  })
  
  output$plot_distribution <- renderPlotly({
    df <- filtered_data() %>% select(HAZ, WAZ, WHZ)
    
    if(nrow(df) == 0) {
      plot_ly() %>% add_text(x = 0.5, y = 0.5, text = "No data available for selected filters", 
                             textposition = "middle center", mode = "text",
                             hoverinfo = "none") %>%
        layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    } else {
      plot_ly() %>%
        add_boxplot(
          x = ~df$HAZ, name = "Height-for-Age (HAZ)", 
          boxpoints = "outliers", 
          marker = list(color = 'steelblue'),
          line = list(color = 'steelblue'),
          orientation = "H") %>%
        add_boxplot(x = ~df$WAZ, name = "Weight-for-Age (WAZ)", 
                    boxpoints = "outliers", 
                    marker = list(color = 'darkorange'),
                    line = list(color = 'darkorange'), 
                    orientation = "H") %>%
        add_boxplot(x = ~df$WHZ, name = "Weight-for-Height (WHZ)", 
                    boxpoints = "outliers", 
                    marker = list(color = 'seagreen'),
                    line = list(color = 'seagreen')) %>%
        layout(yaxis = list(title = "Z-score Value"),
               xaxis = list(title = "Nutritional Indicator"),
               font = list(family = "Arial", size = 12))
    }
  })
  
  # relationship plots
  output$plot_simple_age <- renderPlotly({
    df <- filtered_data() %>% 
      filter(!is.na(HAZ) & !is.na(child_age_months)) %>%
      mutate(age_group = cut(child_age_months, 
                             breaks = c(0, 12, 24, 36, 48, 60),
                             labels = c("0-12m", "13-24m", "25-36m", "37-48m", "49-60m"))) %>%
      group_by(age_group) %>%
      summarize(avg_HAZ = mean(HAZ, na.rm = TRUE), .groups = 'drop')
    
    plot_ly(df, x = ~age_group, y = ~avg_HAZ, type = 'scatter', mode = 'lines+markers',
            line = list(color = '#3d6ab5', width = 4),
            marker = list(size = 12, color = '#3d6ab5', line = list(color = 'white', width = 2)),
            hoverinfo = 'text',
            hovertext = ~paste("Age Group:", age_group, "<br>Average HAZ:", round(avg_HAZ, 2))) %>%
      layout(xaxis = list(title = "Child Age Group"),
             yaxis = list(title = "Average HAZ Score"),
             showlegend = FALSE,
             font = list(family = "Arial", size = 12)) %>%
      add_trace(y = -2, type = 'scatter', mode = 'lines',
                line = list(color = 'red', dash = 'dash', width = 2),
                name = "Stunting Threshold", showlegend = FALSE)
  })
  
  output$plot_simple_wealth <- renderPlotly({
    df <- filtered_data() %>% 
      filter(!is.na(stunted_status) & !is.na(wealth_index)) %>%
      group_by(wealth_index) %>%
      summarize(stunting_rate = mean(stunted_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    # Wealth gradient: Blue shades
    colors <- c('#3d6ab5', '#4a78c7', '#5a8dd4', '#6a9cdc', '#7aabe4')
    
    plot_ly(df, x = ~wealth_index, y = ~stunting_rate, type = 'bar',
            marker = list(color = colors,
                          line = list(color = 'darkgray', width = 1)),
            text = ~paste0(round(stunting_rate, 1), "%"),
            textposition = 'auto',
            hoverinfo = 'text',
            hovertext = ~paste("Wealth Quintile:", wealth_index, "<br>Stunting Rate:", round(stunting_rate, 1), "%")) %>%
      layout(xaxis = list(title = "Wealth Index (Poorest to Richest)"),
             yaxis = list(title = "Stunting Rate (%)"),
             showlegend = FALSE,
             font = list(family = "Arial", size = 12))
  })
  
  # Download handlers for plots
  output$download_stunting <- downloadHandler(
    filename = function() { paste("stunting_prevalence_", Sys.Date(), ".png", sep="") },
    content = function(file) { orca(plot_stunting, file) }
  )
  
  output$download_underweight <- downloadHandler(
    filename = function() { paste("underweight_prevalence_", Sys.Date(), ".png", sep="") },
    content = function(file) { orca(output$plot_underweight, file) }
  )
  
  output$download_wasting <- downloadHandler(
    filename = function() { paste("wasting_prevalence_", Sys.Date(), ".png", sep="") },
    content = function(file) { orca(output$plot_wasting, file) }
  )
  
  output$download_distribution <- downloadHandler(
    filename = function() { paste("nutritional_distribution_", Sys.Date(), ".png", sep="") },
    content = function(file) { orca(output$plot_distribution, file) }
  )
  
  # Data preview
  output$data_preview <- renderDT({
    datatable(filtered_data(), options=list(scrollX=TRUE, pageLength=8), rownames=FALSE)
  })
  
  output$download_filtered <- downloadHandler(
    filename = function() { paste("filtered_hidden_hunger_", Sys.Date(), ".csv", sep="") },
    content = function(file) { write.csv(filtered_data(), file, row.names=FALSE) }
  )
  
  # Enhanced insights
  output$chart_ai_interpretation <- renderUI({
    df <- filtered_data()
    
    # Generate comprehensive interpretation
    stunting_df <- df %>% 
      group_by(urban_rural) %>%
      summarize(stunting_rate = mean(stunted_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    wealth_df <- df %>% 
      group_by(wealth_index) %>%
      summarize(underweight_rate = mean(underweight_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    education_df <- df %>% 
      group_by(hh_education) %>%
      summarize(wasting_rate = mean(wasted_status == "Yes", na.rm = TRUE) * 100, .groups = 'drop')
    
    urban_rate <- stunting_df$stunting_rate[stunting_df$urban_rural == "Urban"]
    rural_rate <- stunting_df$stunting_rate[stunting_df$urban_rural == "Rural"]
    poorest_under <- wealth_df$underweight_rate[wealth_df$wealth_index == 1]
    richest_under <- wealth_df$underweight_rate[wealth_df$wealth_index == 5]
    
    HTML(paste0(
      "<div style='font-size:15px; line-height:1.7; color: #333;'>",
      "<h4 style='color: #3d6ab5; margin-top: 0; font-size: 18px;'>📊 What These Charts Tell Us:</h4>",
      
      "<div style='background: #f0f8ff; padding: 12px; border-left: 4px solid #3d6ab5; margin-bottom: 12px; border-radius: 4px;'>",
      "<b style='color: #3d6ab5;'>Stunting by Area:</b> ",
      ifelse(length(urban_rate) > 0 & length(rural_rate) > 0,
             paste0("Rural children have ", round(rural_rate - urban_rate, 1), "% higher stunting. "),
             ""),
      "Stunting = chronic malnutrition affecting growth. Rural communities need targeted support.",
      "</div>",
      
      "<div style='background: #fff8f0; padding: 12px; border-left: 4px solid #d4a574; margin-bottom: 12px; border-radius: 4px;'>",
      "<b style='color: #d4a574;'>Wealth & Underweight:</b> ",
      ifelse(length(richest_under) > 0 & length(poorest_under) > 0,
             paste0("Poorest families have ", round(poorest_under - richest_under, 1), "% higher underweight rates. "),
             ""),
      "This shows clear socioeconomic disparity. Wealth enables better nutrition access.",
      "</div>",
      
      "<div style='background: #f0fff0; padding: 12px; border-left: 4px solid #3d6ab5; margin-bottom: 12px; border-radius: 4px;'>",
      "<b style='color: #3d6ab5;'>Why This Matters:</b> Malnutrition in first 2 years causes PERMANENT brain damage. ",
      "These visualizations guide resource allocation to highest-risk populations.",
      "</div>",
      
      "<div style='background: #f5f5f5; padding: 12px; border-left: 4px solid #666; margin-bottom: 0; border-radius: 4px;'>",
      "<b>💡 Action:</b> Use the filters to explore specific groups. Ask the chatbot 'stunting chart' for detailed analysis!",
      "</div>",
      "</div>"
    ))
  })
  
  output$simple_insights <- renderUI({
    df <- filtered_data()
    
    # Calculate key statistics
    rural_stunting <- mean(df$stunted_status[df$urban_rural == "Rural"] == "Yes", na.rm = TRUE) * 100
    urban_stunting <- mean(df$stunted_status[df$urban_rural == "Urban"] == "Yes", na.rm = TRUE) * 100
    
    poorest_stunting <- mean(df$stunted_status[df$wealth_index == 1] == "Yes", na.rm = TRUE) * 100
    richest_stunting <- mean(df$stunted_status[df$wealth_index == 5] == "Yes", na.rm = TRUE) * 100
    
    HTML(paste0(
      "<div style='font-size:16px; line-height:1.6;'>
        <h4 style='color:darkblue;'>Key Evidence-Based Findings:</h4>
        <div style='background: #f8f9fa; padding:15px; border-radius:5px;'>
          <ul>
            <li><b>Geographic Disparity:</b> Rural areas exhibit ", round(rural_stunting, 1), 
      "% stunting prevalence compared to ", round(urban_stunting, 1), "% in urban areas</li>
            <li><b>Socioeconomic Gradient:</b> Poorest wealth quintile shows ", round(poorest_stunting, 1), 
      "% stunting rate versus ", round(richest_stunting, 1), "% in the wealthiest quintile</li>
            <li><b>Critical Developmental Window:</b> Highest malnutrition vulnerability observed during first 24 months</li>
            <li><b>Educational Correlation:</b> Household education level inversely associated with wasting rates</li>
          </ul>
        </div>
        <p style='color:darkgreen; font-weight:bold; margin-top:15px;'>✓ Strategic Implications: Targeted interventions needed for rural communities and low-income households during early childhood</p>
      </div>"
    ))
  })
  
  #report summary
  output$report_summary <- renderUI({
    df <- filtered_data()
    total <- nrow(df)
    s <- sum(df$stunted_status == "Yes", na.rm = TRUE)
    u <- sum(df$underweight_status == "Yes", na.rm = TRUE)
    w <- sum(df$wasted_status == "Yes", na.rm = TRUE)
    
    HTML(paste0(
      "<div style='font-size:16px; line-height:1.6;'>
        <h4 style='color:darkblue;'>Comprehensive Nutritional Assessment Report</h4>
        <div style='background: #e8f4f8; padding:15px; border-radius:5px;'>
          <p><strong>Sample Size:</strong> ", format(total, big.mark = ","), " children assessed</p>
          <p><strong>Stunting Prevalence (HAZ < -2):</strong> ", s, " cases (", round(s/total*100,1), "%) - <span style='color:", ifelse(s/total*100 > 30, "red", ifelse(s/total*100 > 20, "orange", "green")), ";'>Chronic malnutrition indicator</span></p>
          <p><strong>Underweight Prevalence (WAZ < -2):</strong> ", u, " cases (", round(u/total*100,1), "%) - <span style='color:", ifelse(u/total*100 > 15, "red", ifelse(u/total*100 > 10, "orange", "green")), ";'>Overall undernutrition measure</span></p>
          <p><strong>Wasting Prevalence (WHZ < -2):</strong> ", w, " cases (", round(w/total*100,1), "%) - <span style='color:", ifelse(w/total*100 > 8, "red", ifelse(w/total*100 > 5, "orange", "green")), ";'>Acute malnutrition indicator</span></p>
        </div>
        <p style='margin-top:15px;'><strong>Interpretation:</strong> This analysis provides critical baseline data for targeting nutritional interventions to vulnerable populations. The findings support evidence-based program planning and resource allocation.</p>
      </div>"
    ))
  })
}

shinyApp(ui, server)
