class TemplateCache < AbstractCache
    @h = {}
    @size = 0
    @max = SETTINGS[:template_cache_max]
end

