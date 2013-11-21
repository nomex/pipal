#coding: ISO-8859-1

require_relative "../list_checker.rb"

register_checker("ES_Colour_Checker")

class ES_Colour_Checker < List_Checker
	def initialize
		super
		@description = "Lista de colores en español"
		@list = {"negro" => 0, "azul" => 0, "marron" => 0, "gris" => 0, "verde" => 0, "naranja" => 0, "rosa" => 0, "morado" => 0, "rojo" => 0, "blanco" => 0, "amarillo" => 0, 'violeta' => 0, 'añil' => 0}
	end

	def get_results()
		return super("Colores")
	end
end
