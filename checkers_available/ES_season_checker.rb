#coding: ISO-8859-1
require_relative "../list_checker.rb"

register_checker("ES_Season_Checker")

class ES_Season_Checker < List_Checker
	def initialize
		super
		@description = "Lista de estaciones en Español"
		@list = {"verano" => 0, "otoño" => 0, "invierno" => 0, "primavera" => 0}
	end

	def get_results()
		return super("Estaciones del año")
	end
end
