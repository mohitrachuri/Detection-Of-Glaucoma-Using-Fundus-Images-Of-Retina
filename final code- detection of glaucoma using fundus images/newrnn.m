function net=newrnn(p,t,spread)
%NEWPNN Design a Recurrent neural network.
%
%  Synopsis
%
%    net = newrnn(P,T,SPREAD)
%
%  Description
%
%    Recurrent neural networks are a kind of radial
%    basis network suitable for classification problems.
%
%    NET = NEWRNN(P,T,SPREAD) takes two or three arguments,
%      P      - RxQ matrix of Q input vectors.
%      T      - SxQ matrix of Q target class vectors.
%      SPREAD - Spread of radial basis functions, default = 0.1.
%    and returns a new probabilistic neural network.
%
%    If SPREAD is near zero the network will act as a nearest
%    neighbor classifier.  As SPREAD becomes larger the designed
%    network will take into account several nearby design vectors.
%
%  Examples
%
%    Here a classification problem is defined with a set of
%    inputs P and class indices Tc.
%
%      P = [1 2 3 4 5 6 7];
%      Tc = [1 2 3 2 2 3 1];
%
%    Here the class indices are converted to target vectors,
%    and a RNN is designed and tested.
%
%      T = ind2vec(Tc)
%      net = newrnn(P,T);
%      Y = sim(net,P)
%      Yc = vec2ind(Y)
%
%  Algorithm
%
%    NEWRNN creates a two layer network. The first layer has RADBAS
%    neurons, and calculates its weighted inputs with DIST, and its net
%    input with NETPROD.  The second layer has COMPET neurons, and
%    calculates its weighted input with DOTPROD and its net inputs with
%    NETSUM. Only the first layer has biases.
%
%    NEWRNN sets the first layer weights to P', and the first
%    layer biases are all set to 0.8326/SPREAD resulting in
%    radial basis functions that cross 0.5 at weighted inputs
%    of +/- SPREAD. The second layer weights W2 are set to T.
%
%  References
%
%    P.D. Wasserman, Advanced Methods in Neural Computing, New York:
%       Van Nostrand Reinhold, pp. 35-55, 1993.
%
%  See also SIM, IND2VEC, VEC2IND, NEWRB, NEWRBE, NEWGRNN.

% Mark Beale, 11-31-97
% Copyright 1992-2007 The MathWorks, Inc.
% $Revision: 1.1.6.7 $ $Date: 2007/11/09 20:51:02 $

% Defaults
if nargin < 3, spread = 0.1; end

% Format
if isa(p,'cell'), p = cell2mat(p); end
if isa(t,'cell'), t = cell2mat(t); end

% Error checks
if (~isa(p,'double') && ~islogical(p)) || (~isreal(p)) || (isempty(p))
  error('NNET:Arguments','Inputs are not a non-empty real matrix.')
end
if (~isa(t,'double') && ~islogical(t)) || (~isreal(t)) || (isempty(t))
  error('NNET:Arguments','Targets are not a non-empty real matrix.')
end
if (size(p,2) ~= size(t,2))
  error('NNET:Arguments','Inputs and Targets have different numbers of columns.')
end
if (~isa(spread,'double')) || ~isreal(spread) || any(size(spread) ~= 1) || (spread < 0)
  error('NNET:Arguments','Spread is not a positive or zero real value.')
end

% Dimensions
[R,Q] = size(p);
[S,Q] = size(t);

% Architecture
net = network(1,2,[1;0],[1;0],[0 0;1 0],[0 1]);

% Simulation
net.inputs{1}.size = R;
net.inputWeights{1,1}.weightFcn = 'dist';
net.layers{1}.netInputFcn = 'netprod';
net.layers{1}.transferFcn = 'radbas';
net.layers{1}.size = Q;
net.layers{2}.size = S;
net.layers{2}.transferFcn = 'compet';
net.outputs{2}.exampleOutput = t;

% Weight and Bias Values
net.b{1} = zeros(Q,1)+sqrt(-log(.5))/spread;
net.iw{1,1} = p';
net.lw{2,1} = t;
