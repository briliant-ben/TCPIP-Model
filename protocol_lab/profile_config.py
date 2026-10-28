"""Profile execution settings; does not import optional formal backends."""
from .ir import require


def profile_group_size(profile):
    key = 'inductive_refinement_group_size'
    require(type(profile.get('inductive_refinement', False)) is bool,
            'Refinement enable flag must be boolean')
    require(key not in profile or profile.get('inductive_refinement') is True,
            'Refinement group size requires enabled refinement')
    size = profile.get(key, 8)
    require(type(size) is int and size >= 1, 'Positive integer profile refinement group size required')
    return size
