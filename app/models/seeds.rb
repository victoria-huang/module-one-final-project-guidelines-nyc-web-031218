# require_relative 'prescription'
# require_relative 'interaction'

a = Prescription.create(name: "a", rxcui: 1)
b = Prescription.create(name: "b", rxcui: 2)
c = Prescription.create(name: "c", rxcui: 3)
d = Prescription.create(name: "d", rxcui: 4)
e = Prescription.create(name: "e", rxcui: 5)

i1 = Interaction.create(med1: a, med2: b)
# i2 = Interaction.create(med1_id: 1, med2_id: 3)
# i3 = Interaction.create(med1_id: 1, med2_id: 4)
#
# i4 = Interaction.create(med1_id: 2, med2_id: 4)
# i5 = Interaction.create(med1_id: 2, med2_id: 5)
# i6 = Interaction.create(med1_id: 2, med2_id: 3)
