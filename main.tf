terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

# Création d'un groupe de ressources
resource "azurerm_resource_group" "example" {
  name     = "rg-{remplacez_par_votre_nom}-${random_integer.random_number.result}"
  location = "West Europe"  # Remplacez par votre emplacement préféré
}

# Création d'un plan de service App Service
resource "azurerm_app_service_plan" "example" {
  name                = "asp-{remplacez_par_votre_nom}-${random_integer.random_number.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Création de l'application Web
resource "azurerm_linux_web_app" "example" {
  name                = "webapp-{remplacez_par_votre_nom}-${random_integer.random_number.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  site_config {
    # Configuration pour une application Java
    application_stack {
      java_server        = "JAVA"
      java_version       = "java17"
      java_server_version = "17"
    }
  }
}
