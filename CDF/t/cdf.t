use strict;
use warnings;
use Test::More;
use PDL::LiteF;
use PDL::GSL::CDF;
use Test::PDL;

{
  my $a = sequence 5;
  my $a_bad = $a->append(pdl 'BAD');
  is_pdl $a->gsl_cdf_tdist_P(1999), my $texp = pdl('0.5 0.841284230695725 0.977182329566921 0.998633419750658 0.999967176033837');
  is_pdl $a_bad->gsl_cdf_tdist_P(1999), $texp->append(pdl 'BAD');
  is_pdl $a->gsl_cdf_fdist_P(1,1999), my $fexp = pdl('0 0.682568461391451 0.842545068166059 0.916581225902023 0.95436465913384');
  is_pdl $a_bad->gsl_cdf_fdist_P(1,1999), $fexp->append(pdl 'BAD');
}
{
  my $x = pdl('[0.185 0.242 0.385 0.528 0.671 0.814]');
  ok(all(approx(gsl_cdf_gaussian_P            ($x, 0.6)     , pdl([ 0.621085647787498, 0.656648488459185, 0.739455181655133, 0.810570345223288, 0.868287672230057, 0.912556425780295 ]))));
  ok(all(approx(gsl_cdf_gaussian_Q            ($x, 0.6)     , pdl([ 0.378914352212502, 0.343351511540815, 0.260544818344867, 0.189429654776712, 0.131712327769943, 0.0874435742197054 ]))));
  ok(all(approx(gsl_cdf_gaussian_Pinv         ($x, 0.6)     , pdl([ -0.53788401840115, -0.419930160118405, -0.175424937736083, 0.04214598829315, 0.265605686522293, 0.535639994592513 ]))));
  ok(all(approx(gsl_cdf_gaussian_Qinv         ($x, 0.6)     , pdl([ 0.53788401840115, 0.419930160118405, 0.175424937736083, -0.04214598829315, -0.265605686522293, -0.535639994592513 ]))));
  ok(all(approx(gsl_cdf_ugaussian_P           ($x)          , pdl([ 0.573385482213374, 0.5956099183852, 0.649881292234724, 0.701250332027385, 0.748889735236971, 0.792177524517595 ]))));
  ok(all(approx(gsl_cdf_ugaussian_Q           ($x)          , pdl([ 0.426614517786626, 0.4043900816148, 0.350118707765276, 0.298749667972615, 0.251110264763029, 0.207822475482405 ]))));
  ok(all(approx(gsl_cdf_ugaussian_Pinv        ($x)          , pdl([ -0.896473364001916, -0.699883600197341, -0.292374896226804, 0.0702433138219167, 0.442676144203822, 0.892733324320856 ]))));
  ok(all(approx(gsl_cdf_ugaussian_Qinv        ($x)          , pdl([ 0.896473364001916, 0.699883600197341, 0.292374896226804, -0.0702433138219167, -0.442676144203822, -0.892733324320856 ]))));
  ok(all(approx(gsl_cdf_exponential_Pinv      ($x, 0.25)    , pdl([ 0.0511417914353186, 0.0692679733349413, 0.121533252793905, 0.187694073349145, 0.277924382054191, 0.420502151317234 ]))));
  ok(all(approx(gsl_cdf_exponential_Q         ($x, 0.25)    , pdl([ 0.477113915521034, 0.379841962851379, 0.214381101426978, 0.120995732814878, 0.0682894493122845, 0.0385422591266925 ]))));
  ok(all(approx(gsl_cdf_exponential_P         ($x, 0.25)    , pdl([ 0.522886084478966, 0.620158037148621, 0.785618898573022, 0.879004267185122, 0.931710550687715, 0.961457740873307 ]))));
  ok(all(approx(gsl_cdf_exponential_Qinv      ($x, 0.25)    , pdl([ 0.421849863475953, 0.354704388206363, 0.238627986173588, 0.159664748818969, 0.0997465355026138, 0.0514487282448992 ]))));
  ok(all(approx(gsl_cdf_laplace_P             ($x, 100)     , pdl([ 0.500924144902391, 0.501208537080327, 0.501921299125978, 0.502633042650321, 0.5033437691088, 0.504053479954779 ]))));
  ok(all(approx(gsl_cdf_laplace_Q             ($x, 100)     , pdl([ 0.499075855097609, 0.498791462919674, 0.498078700874022, 0.497366957349679, 0.4966562308912, 0.495946520045221 ]))));
  ok(all(approx(gsl_cdf_laplace_Pinv          ($x, 100)     , pdl([ -99.4252273343867, -72.5670372265505, -26.1364764134408, 5.76291128366364, 41.855034765682, 98.886142470899 ]))));
  ok(all(approx(gsl_cdf_laplace_Qinv          ($x, 100)     , pdl([ 99.4252273343867, 72.5670372265505, 26.1364764134408, -5.76291128366364, -41.855034765682, -98.886142470899 ]))));
  ok(all(approx(gsl_cdf_exppow_P              ($x, 10, 20)  , pdl([ 0.509501756003763, 0.512429324069787, 0.51977392465648, 0.527118525243172, 0.534463125829865, 0.541807726416557 ]))));
  ok(all(approx(gsl_cdf_exppow_Q              ($x, 10, 20)  , pdl([ 0.490498243996237, 0.487570675930213, 0.48022607534352, 0.472881474756828, 0.465536874170135, 0.458192273583443 ]))));
  ok(all(approx(gsl_cdf_cauchy_P              ($x, 10)      , pdl([ 0.505888061226044, 0.507701596026139, 0.512248881040388, 0.516791169875417, 0.521326624632281, 0.525853424029018 ]))));
  ok(all(approx(gsl_cdf_cauchy_Q              ($x, 10)      , pdl([ 0.494111938773956, 0.492298403973861, 0.487751118959612, 0.483208830124583, 0.478673375367719, 0.474146575970982 ]))));
  ok(all(approx(gsl_cdf_cauchy_Pinv           ($x, 10)      , pdl([ -15.2235450689613, -10.5157249987904, -3.77868511775821, 0.881921819968596, 5.95646629389323, 15.1198164986352 ]))));
  ok(all(approx(gsl_cdf_cauchy_Qinv           ($x, 10)      , pdl([ 15.2235450689613, 10.5157249987904, 3.77868511775821, -0.881921819968596, -5.95646629389323, -15.1198164986352 ]))));
  ok(all(approx(gsl_cdf_rayleigh_P            ($x, 0.6)     , pdl([ 0.0464226377672899, 0.078118776801827, 0.1860595358795, 0.321044709711432, 0.46491770539411, 0.601589429889673 ]))));
  ok(all(approx(gsl_cdf_rayleigh_Q            ($x, 0.6)     , pdl([ 0.95357736223271, 0.921881223198173, 0.8139404641205, 0.678955290288568, 0.53508229460589, 0.398410570110327 ]))));
  ok(all(approx(gsl_cdf_rayleigh_Pinv         ($x, 0.6)     , pdl([ 0.383781655806681, 0.44664500803729, 0.591621304591413, 0.735227129019012, 0.894663188197699, 1.10047544079531 ]))));
  ok(all(approx(gsl_cdf_rayleigh_Qinv         ($x, 0.6)     , pdl([ 1.10223754554576, 1.01071689311811, 0.829004583931798, 0.678110961862902, 0.535975766474127, 0.384931600866063 ]))));
  ok(all(approx(gsl_cdf_gamma_P               ($x, 1, 2)    , pdl([ 0.0883507890355383, 0.113966040407124, 0.175105681796397, 0.232026460343294, 0.285019493288257, 0.334355809698479 ]))));
  ok(all(approx(gsl_cdf_gamma_Q               ($x, 1, 2)    , pdl([ 0.911649210964462, 0.886033959592876, 0.824894318203603, 0.767973539656706, 0.714980506711743, 0.665644190301521 ]))));
  ok(all(approx(gsl_cdf_gamma_Pinv            ($x, 1, 2)    , pdl([ 0.409134331482549, 0.554143786679531, 0.972266022351238, 1.50155258679316, 2.22339505643353, 3.36401721053787 ]))));
  ok(all(approx(gsl_cdf_gamma_Qinv            ($x, 1, 2)    , pdl([ 3.37479890780762, 2.8376351056509, 1.90902388938871, 1.27731799055175, 0.79797228402091, 0.411589825959194 ]))));
  ok(all(approx(gsl_cdf_flat_P                ($x, 0, 2)    , pdl([0.0925, 0.121, 0.1925, 0.264, 0.3355, 0.407]))));
  ok(all(approx(gsl_cdf_flat_Q                ($x, 0, 2)    , pdl([0.9075, 0.879, 0.8075, 0.736, 0.6645, 0.593]))));
  ok(all(approx(gsl_cdf_flat_Pinv             ($x, 1, 2)    , pdl([1.185, 1.242, 1.385, 1.528, 1.671, 1.814]))));
  ok(all(approx(gsl_cdf_flat_Qinv             ($x, 1, 2)    , pdl([1.815, 1.758, 1.615, 1.472, 1.329, 1.186]))));
  ok(all(approx(gsl_cdf_lognormal_P           ($x, 0.3, 0.6), pdl([ 0.000462607682986099, 0.00208704926075921, 0.0182706108740019, 0.0588581153586641, 0.122014171048952, 0.199616592770584 ]))));
  ok(all(approx(gsl_cdf_lognormal_Q           ($x, 0.3, 0.6), pdl([ 0.999537392317014, 0.997912950739241, 0.981729389125998, 0.941141884641336, 0.877985828951048, 0.800383407229416 ]))));
  ok(all(approx(gsl_cdf_lognormal_Pinv        ($x, 0.3, 0.6), pdl([ 0.788294113403652, 0.886982381298518, 1.13266703782153, 1.40796582903933, 1.76051377932779, 2.30628958893332 ]))));
  ok(all(approx(gsl_cdf_lognormal_Qinv        ($x, 0.3, 0.6), pdl([ 2.31147076885183, 2.05428973428196, 1.60869764860025, 1.29414987410153, 1.03499263782317, 0.790065050431614 ]))));
  ok(all(approx(gsl_cdf_chisq_P               ($x, 0.9)     , pdl([ 0.376001891123672, 0.420680573652885, 0.507543979704043, 0.573017615826538, 0.625398070381443, 0.668713631235268 ]))));
  ok(all(approx(gsl_cdf_chisq_Q               ($x, 0.9)     , pdl([ 0.623998108876328, 0.579319426347115, 0.492456020295957, 0.426982384173462, 0.374601929618557, 0.331286368764732 ]))));
  ok(all(approx(gsl_cdf_chisq_Pinv            ($x, 0.9)     , pdl([ 0.0363724832898845, 0.0667572490273275, 0.195682928939501, 0.425980141237634, 0.822286592027187, 1.57020451220134 ]))));
  ok(all(approx(gsl_cdf_chisq_Qinv            ($x, 0.9)     , pdl([ 1.57778431676383, 1.21061535673313, 0.640242963605861, 0.320808004604559, 0.135209087406343, 0.0368164405929002 ]))));
  ok(all(approx(gsl_cdf_fdist_P               ($x, 0.5, 0.8), pdl([ 0.395899685715852, 0.421622763059381, 0.468763623791231, 0.502470355270446, 0.528704043285766, 0.550125367078533 ]))));
  ok(all(approx(gsl_cdf_fdist_Q               ($x, 0.5, 0.8), pdl([ 0.604100314284148, 0.578377236940619, 0.531236376208769, 0.497529644729554, 0.471295956714234, 0.449874632921467 ]))));
  ok(all(approx(gsl_cdf_fdist_Pinv            ($x, 1.5, 1.8), pdl([ 0.159905620801234, 0.241769364468725, 0.535256991978199, 1.04012738093102, 2.03748438382058, 4.73267894511171 ]))));
  ok(all(approx(gsl_cdf_fdist_Qinv            ($x, 1.5, 1.8), pdl([ 4.76724629388056, 3.2748615203822, 1.55210103408465, 0.806318097041121, 0.402458766933549, 0.161204550680556 ]))));
  ok(all(approx(gsl_cdf_tdist_P               ($x, 0.7)     , pdl([ 0.553772454538094, 0.569686093296725, 0.607329840803688, 0.641083174744614, 0.670718124690489, 0.696452396237433 ]))));
  ok(all(approx(gsl_cdf_tdist_Q               ($x, 0.7)     , pdl([ 0.446227545461906, 0.430313906703275, 0.392670159196312, 0.358916825255386, 0.329281875309511, 0.303547603762567 ]))));
  ok(all(approx(gsl_cdf_tdist_Pinv            ($x, 2)       , pdl([ -1.14725744068977, -0.851907453506246, -0.33422960488652, 0.079320431592384, 0.514697310821784, 1.1412373360793 ]))));
  ok(all(approx(gsl_cdf_tdist_Qinv            ($x, 2)       , pdl([ 1.14725744068977, 0.851907453506246, 0.33422960488652, -0.079320431592384, -0.514697310821784, -1.1412373360793 ]))));
  ok(all(approx(gsl_cdf_beta_P                ($x, 1, 2)    , pdl([ 0.335775, 0.425436, 0.621775, 0.777216, 0.891759, 0.965404 ]))));
  ok(all(approx(gsl_cdf_beta_Q                ($x, 1, 2)    , pdl([ 0.664225, 0.574564, 0.378225, 0.222784, 0.108241, 0.034596 ]))));
  ok(all(approx(gsl_cdf_beta_Pinv             ($x, 1, 2)    , pdl([ 0.0972264957366104, 0.129368045612843, 0.215780642932094, 0.312977438507293, 0.426414784012001, 0.568722826943044 ]))));
  ok(all(approx(gsl_cdf_beta_Qinv             ($x, 1, 2)    , pdl([ 0.569883736647869, 0.508065044950046, 0.379516317700457, 0.273363915016602, 0.180854103349104, 0.097780514508803 ]))));
  ok(all(approx(gsl_cdf_logistic_P            ($x, 2)       , pdl([ 0.523108525489089, 0.53021314643553, 0.547976937636796, 0.565619324932982, 0.583097006692731, 0.600368317448984 ]))));
  ok(all(approx(gsl_cdf_logistic_Q            ($x, 2)       , pdl([ 0.476891474510911, 0.46978685356447, 0.452023062363204, 0.434380675067018, 0.416902993307269, 0.399631682551016 ]))));
  ok(all(approx(gsl_cdf_logistic_Pinv         ($x, 2)       , pdl([ -2.96566457632508, -2.28349131897137, -0.936757867037467, 0.224234596241412, 1.42542277241262, 2.95242738457868 ]))));
  ok(all(approx(gsl_cdf_logistic_Qinv         ($x, 2)       , pdl([ 2.96566457632508, 2.28349131897137, 0.936757867037467, -0.224234596241412, -1.42542277241262, -2.95242738457868 ]))));
  ok(all(approx(gsl_cdf_pareto_P              ($x, 0.1, .05), pdl([ 0.122635965393589, 0.145886740885255, 0.184637135967562, 0.209988145413383, 0.228697483330511, 0.243455357847612 ]))));
  ok(all(approx(gsl_cdf_pareto_Q              ($x, 0.1, .05), pdl([ 0.877364034606411, 0.854113259114745, 0.815362864032438, 0.790011854586617, 0.771302516669489, 0.756544642152388 ]))));
  ok(all(approx(gsl_cdf_pareto_Pinv           ($x, 11, 22)  , pdl([ 22.4129623633136, 22.5611817388298, 22.994070157874, 23.553980832887, 24.3396294860749, 25.6348390467721 ]))));
  ok(all(approx(gsl_cdf_pareto_Qinv           ($x, 11, 22)  , pdl([ 25.6474051745322, 25.0287675983915, 23.9942991451309, 23.3151266418161, 22.8126206663786, 22.4154640895281 ]))));
  ok(all(approx(gsl_cdf_weibull_P             ($x, 1, 2)    , pdl([ 0.0336459494865304, 0.0568821210761311, 0.137762910230166, 0.243296666516025, 0.362525498247215, 0.484488671492325 ]))));
  ok(all(approx(gsl_cdf_weibull_Q             ($x, 1, 2)    , pdl([ 0.96635405051347, 0.943117878923869, 0.862237089769834, 0.756703333483975, 0.637474501752785, 0.515511328507675 ]))));
  ok(all(approx(gsl_cdf_weibull_Pinv          ($x, 1, 2)    , pdl([ 0.452291018859842, 0.526376189943813, 0.6972323939517, 0.866473481069433, 1.05437067875428, 1.29692274452603 ]))));
  ok(all(approx(gsl_cdf_weibull_Qinv          ($x, 1, 2)    , pdl([ 1.29899940488971, 1.19114128163936, 0.976991271554845, 0.799161432550317, 0.631653498375854, 0.453646242108977 ]))));
  ok(all(approx(gsl_cdf_gumbel1_P             ($x, 1, 2)    , pdl([ 0.189719508676777, 0.208021808732089, 0.256429559887203, 0.307411906647793, 0.359732618472373, 0.412233898397574 ]))));
  ok(all(approx(gsl_cdf_gumbel1_Q             ($x, 1, 2)    , pdl([ 0.810280491323223, 0.791978191267911, 0.743570440112797, 0.692588093352207, 0.640267381527627, 0.587766101602426 ]))));
  ok(all(approx(gsl_cdf_gumbel1_Pinv          ($x, 1, 2)    , pdl([ 0.169958621442342, 0.343323365119587, 0.73970230236935, 1.14153180132375, 1.61197577505875, 2.27402235471976 ]))));
  ok(all(approx(gsl_cdf_gumbel1_Qinv          ($x, 1, 2)    , pdl([ 2.28000609915082, 1.9766254442873, 1.4144201875401, 0.979794730452658, 0.58725902873148, 0.173158502928973 ]))));
  ok(all(approx(gsl_cdf_gumbel2_P             ($x, 1, 2)    , pdl([ 2.01801560369643e-05, 0.000257507217296498, 0.00554529646233709, 0.0226435827865344, 0.0507610509809621, 0.0856914301179353 ]))));
  ok(all(approx(gsl_cdf_gumbel2_Q             ($x, 1, 2)    , pdl([ 0.999979819843963, 0.999742492782704, 0.994454703537663, 0.977356417213466, 0.949238949019038, 0.914308569882065 ]))));
  ok(all(approx(gsl_cdf_gumbel2_Pinv          ($x, 1, 2)    , pdl([ 1.18525580612995, 1.40962451163448, 2.09531165232346, 3.13156162332933, 5.0127054286201, 9.71841320586135 ]))));
  ok(all(approx(gsl_cdf_gumbel2_Qinv          ($x, 1, 2)    , pdl([ 9.77674003915904, 7.21834313792145, 4.11410036764091, 2.6639093663331, 1.79905050540872, 1.18905455877868 ]))));
  my $y = long('[7 8 9 10 11 12 14]');
  ok(all(approx(gsl_cdf_poisson_P             ($y, 10)      , pdl([ 0.220220646601699, 0.332819678750718, 0.457929714471852, 0.583039750192985, 0.696776146303107, 0.791556476394874, 0.916541527065337 ]))));
  ok(all(approx(gsl_cdf_poisson_Q             ($y, 10)      , pdl([ 0.779779353398301, 0.667180321249282, 0.542070285528148, 0.416960249807015, 0.303223853696893, 0.208443523605126, 0.0834584729346629 ]))));
  ok(all(approx(gsl_cdf_binomial_P            ($y, 0.3, 33) , pdl([ 0.182152437649663, 0.304315672104686, 0.449748094074962, 0.599335728101516, 0.733381789761681, 0.838703695351808, 0.956260798765594 ]))));
  ok(all(approx(gsl_cdf_binomial_Q            ($y, 0.3, 33) , pdl([ 0.817847562350337, 0.695684327895314, 0.550251905925038, 0.400664271898484, 0.266618210238319, 0.161296304648192, 0.0437392012344063 ]))));
  ok(all(approx(gsl_cdf_negative_binomial_P   ($y, 0.3, 3.3), pdl([ 0.559244604008049, 0.633219417269081, 0.69823505870183, 0.754213525975423, 0.801591665095168, 0.841112929477554, 0.900208316084222 ]))));
  ok(all(approx(gsl_cdf_negative_binomial_Q   ($y, 0.3, 3.3), pdl([ 0.440755395991951, 0.366780582730919, 0.30176494129817, 0.245786474024577, 0.198408334904832, 0.158887070522446, 0.0997916839157782 ]))));
  ok(all(approx(gsl_cdf_pascal_P              ($y, 0.3, 3)  , pdl([ 0.617217213599996, 0.687259545750001, 0.747184652145002, 0.7975217415168, 0.839164242724381, 0.873172285377237, 0.922614747387929 ]))));
  ok(all(approx(gsl_cdf_pascal_Q              ($y, 0.3, 3)  , pdl([ 0.382782786400004, 0.312740454249998, 0.252815347854998, 0.2024782584832, 0.160835757275619, 0.126827714622763, 0.077385252612071 ]))));
  ok(all(approx(gsl_cdf_geometric_P           ($y, 0.3)     , pdl([ 0.9176457, 0.94235199, 0.959646393, 0.9717524751, 0.98022673257, 0.986158712799, 0.99321776927151 ]))));
  ok(all(approx(gsl_cdf_geometric_Q           ($y, 0.3)     , pdl([ 0.0823543, 0.05764801, 0.040353607, 0.0282475249, 0.01977326743, 0.013841287201, 0.00678223072849001 ]))));
  my $z = long('[6 7 8 9 10]');
  ok(all(approx(gsl_cdf_hypergeometric_P     ($z, 25, 5, 11), pdl([ 0.00324196875921016, 0.0472401162056337, 0.24523177971454, 0.61921603300914, 0.918403435644814 ]))));
  ok(all(approx(gsl_cdf_hypergeometric_Q     ($z, 25, 5, 11), pdl([ 0.99675803124079, 0.952759883794366, 0.75476822028546, 0.38078396699086, 0.0815965643551856 ]))));
}

done_testing;
