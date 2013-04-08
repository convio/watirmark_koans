module TraitHelper
  def trait(trait_name)
    Watirmark::Model::Traits.instance[trait_name]
  end

  def trait_keys(trait_name)
    trait(trait_name).defaults.keys
  end

  def trait_values(trait_name)
    values = []
    trait = trait(trait_name)
    trait.defaults.values.each do |v|
      values << instance_eval(&v)
    end
    values
  end
end
