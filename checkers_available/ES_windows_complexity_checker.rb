#coding: ISO-8859-1
register_checker("ES_Windows_Complexity_Checker")

class ES_Windows_Complexity_Checker < Checker

	def initialize
		super
		@description = "Comprueba la complejidad por defecto de Windows"
		@matches = 0
	end

	def process_word (word, extras = nil)
		if word =~ /(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*/
			@matches += 1
		end
		@total_words_processed += 1
	end

	def get_results()
		ret_str = "Complejidad por defecto del Active Directory\n"

		ret_str << "Numero de ocurrencias = #{@matches} (#{((@matches.to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		return ret_str
	end
end
