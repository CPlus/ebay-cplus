# Fix DateTime detection in Nori
original_verbose, $VERBOSE = $VERBOSE, nil
Nori::XMLUtilityNode::XS_DATE_TIME = /^-?\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:?\d{2})?$/
$VERBOSE = original_verbose
