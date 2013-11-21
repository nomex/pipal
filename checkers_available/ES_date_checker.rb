#coding: ISO-8859-1
register_checker("ES_Date_Checker")

class ES_Date_Checker < Checker

	def initialize
		super

		@years = {}
		1975.upto(2020) do |year|
			@years[year] = 0
		end

		@days_ab = {'lun' => 0, 'mar' => 0, 'mie' => 0, 'jue' => 0, 'vie' => 0, 'sab' => 0, 'dom' => 0}
		@months_ab = {"ene" => 0, "feb" => 0, "mar" => 0, "abr" => 0, "may" => 0, "jun" => 0, "jul" => 0, "ago" => 0, "sep" => 0, "oct" => 0, "nov" => 0, "dic" => 0}

		@days = {'lunes' => 0, 'martes' => 0, 'miercoles' => 0, 'jueves' => 0, 'viernes' => 0, 'sabado' => 0, 'domingo' => 0}
		@months = {"enero" => 0, "febrero" => 0, "marzo" => 0, "abril" => 0, "mayo" => 0, "junio" => 0, "julio" => 0, "agosto" => 0, "septiembre" => 0, "octubre" => 0, "noviembre" => 0, "diciembre" => 0}
		@description = "Dias, meses y años"
	end

	def process_word (word, extras = nil)
		@years.each_pair do |year, count|
			if /#{year}/.match word
				@years[year] += 1
			end
		end

		@days_ab.each_pair do |day, count|
			if /#{day}/i.match word
				@days_ab[day] += 1
			end
		end

		@months_ab.each_pair do |month, count|
			if /#{month}/i.match word
				@months_ab[month] += 1
			end
		end

		@days.each_pair do |day, count|
			if /#{day}/i.match word
				@days[day] += 1
			end
		end

		@months.each_pair do |month, count|
			if /#{month}/i.match word
				@months[month] += 1
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		ret_str = "Fechas\n"

		ret_str << "\nMeses\n"
		disp = false
		@months.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str = "Ninguno encontrado\n"
		end

		ret_str << "\nDias\n"
		disp = false
		@days.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "Ninguno encontrado\n"
		end

		ret_str << "\nMeses (Abreviados)\n"
		disp = false
		@months_ab.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "Ninguno encontrado\n"
		end

		ret_str << "\nDias (Abreviados)\n"
		disp = false
		@days_ab.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s} %)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "Ninguno encontrado\n"
		end

		ret_str << "\nAños incluidos\n"
		disp = false
		@years.each_pair do |number, count|
			unless count == 0
				disp = true
				ret_str << "#{number.to_s} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "Ninguno encontrado\n"
		end

		count_ordered = []
		@years.each_pair do |year, count|
			count_ordered << [year, count] unless count == 0
		end
		@years = count_ordered.sort do |x,y|
			(x[1] <=> y[1]) * -1
		end

		ret_str << "\nAños (Top #{@cap_at.to_s})\n"
		disp = false
		@years[0, @cap_at].each do |data|
			disp = true
			ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		end
		unless disp
			ret_str << "Ninguno encontrado\n"
		end

		return ret_str
	end
end
