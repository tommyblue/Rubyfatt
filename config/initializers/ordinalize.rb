class Integer
	def ordinal
		to_s + ([[nil, 'st','nd','rd'],[]][self % 100 / 10 == 1 ? 1 : 0][self % 10] || 'th')
	end
end