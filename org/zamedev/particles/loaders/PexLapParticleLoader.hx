package org.zamedev.particles.loaders;

import flash.display.BitmapData;
import flash.errors.Error;
import org.zamedev.particles.ParticleSystem;
import org.zamedev.particles.util.MathHelper;
import org.zamedev.particles.util.ParticleColor;
import org.zamedev.particles.util.ParticleVector;

class PexLapParticleLoader {
    #if openfl
    public static function load(path : String) : ParticleSystem {
        var root = Xml.parse(openfl.Assets.getText(path)).firstElement();

        var map = _initConfigMap(root);
        var ps = _initPSFromConfig(map);
        ps.textureBitmapData = ParticleLoader.loadTexture(map["texture"].get("data"), map["texture"].get("name"), path);

        return ps;
    }
    #end

    public static function loadFromConfig(root : Xml, bitmapData : BitmapData = null) : ParticleSystem {
        var map = _initConfigMap(root);
        var ps = _initPSFromConfig(map);
        ps.textureBitmapData = bitmapData;

        return ps;
    }

    private static function _initConfigMap(root : Xml) : Map<String, Xml> {
        if (root.nodeName != "particleEmitterConfig" && root.nodeName != "lanicaAnimoParticles") {
            throw new Error('Expecting "particleEmitterConfig" or "lanicaAnimoParticles", but "${root.nodeName}" found');
        }

        var map : Map<String, Xml> = new Map<String, Xml>();

        for (node in root.elements()) {
            map[node.nodeName] = node;
        }

        return map;
    }

    private static function _initPSFromConfig(map : Map<String, Xml>) {
        var ps = new ParticleSystem();

        ps.emitterType = parseIntNode(map["emitterType"]);
        ps.maxParticles = parseIntNode(map["maxParticles"]);
        ps.positionType = 0;
        ps.duration = parseFloatNode(map["duration"]);
        ps.gravity = parseVectorNode(map["gravity"]);
        ps.particleLifespan = parseFloatNode(map["particleLifeSpan"]);
        ps.particleLifespanVariance = parseFloatNode(map["particleLifespanVariance"]);
        ps.speed = parseFloatNode(map["speed"]);
        ps.speedVariance = parseFloatNode(map["speedVariance"]);
        ps.sourcePosition = parseVectorNode(map["sourcePosition"]);
        ps.sourcePositionVariance = parseVectorNode(map["sourcePositionVariance"]);
        ps.angle = MathHelper.deg2rad(parseFloatNode(map["angle"]));
        ps.angleVariance = MathHelper.deg2rad(parseFloatNode(map["angleVariance"]));
        ps.startParticleSize = parseFloatNode(map["startParticleSize"]);
        ps.startParticleSizeVariance = parseFloatNode(map["startParticleSizeVariance"]);
        ps.finishParticleSize = parseFloatNode(map["finishParticleSize"]);
        ps.finishParticleSizeVariance = parseFloatNode(map["finishParticleSizeVariance"]);
        ps.startColor = parseColorNode(map["startColor"]);
        ps.startColorVariance = parseColorNode(map["startColorVariance"]);
        ps.finishColor = parseColorNode(map["finishColor"]);
        ps.finishColorVariance = parseColorNode(map["finishColorVariance"]);
        ps.minRadius = parseFloatNode(map["minRadius"]);
        ps.minRadiusVariance = parseFloatNode(map["minRadiusVariance"]);
        ps.maxRadius = parseFloatNode(map["maxRadius"]);
        ps.maxRadiusVariance = parseFloatNode(map["maxRadiusVariance"]);
        ps.rotationStart = MathHelper.deg2rad(parseFloatNode(map["rotationStart"]));
        ps.rotationStartVariance = MathHelper.deg2rad(parseFloatNode(map["rotationStartVariance"]));
        ps.rotationEnd = MathHelper.deg2rad(parseFloatNode(map["rotationEnd"]));
        ps.rotationEndVariance = MathHelper.deg2rad(parseFloatNode(map["rotationEndVariance"]));
        ps.rotatePerSecond = MathHelper.deg2rad(parseFloatNode(map["rotatePerSecond"]));
        ps.rotatePerSecondVariance = MathHelper.deg2rad(parseFloatNode(map["rotatePerSecondVariance"]));
        ps.radialAcceleration = parseFloatNode(map["radialAcceleration"]);
        ps.radialAccelerationVariance = parseFloatNode(map["radialAccelVariance"]);
        ps.tangentialAcceleration = parseFloatNode(map["tangentialAcceleration"]);
        ps.tangentialAccelerationVariance = parseFloatNode(map["tangentialAccelVariance"]);
        ps.blendFuncSource = parseIntNode(map["blendFuncSource"]);
        ps.blendFuncDestination = parseIntNode(map["blendFuncDestination"]);
        ps.yCoordMultiplier = (parseIntNode(map["yCoordFlipped"]) == 1 ? -1.0 : 1.0);
        ps.headToVelocity = (parseIntNode(map["headToVelocity"]) == 1); // custom property
        ps.forceSquareTexture = true;

        return ps;
    }

    private static function parseIntNode(node : Xml) : Int {
        return (node == null ? 0 : parseIntString(node.get("value")));
    }

    private static function parseFloatNode(node : Xml) : Float {
        return (node == null ? 0 : parseFloatString(node.get("value")));
    }

    private static function parseVectorNode(node : Xml) : ParticleVector {
        if (node == null) {
            return new ParticleVector(0.0, 0.0);
        }

        return new ParticleVector(
            parseFloatString(node.get("x")),
            parseFloatString(node.get("y"))
        );
    }

    private static function parseColorNode(node : Xml) : ParticleColor {
        if (node == null) {
            return new ParticleColor(0.0, 0.0, 0.0, 0.0);
        }

        return new ParticleColor(
            parseFloatString(node.get("red")),
            parseFloatString(node.get("green")),
            parseFloatString(node.get("blue")),
            parseFloatString(node.get("alpha"))
        );
    }

    private static function parseIntString(s : String) : Int {
        if (s == null) {
            return 0;
        }

        var result = Std.parseInt(s);
        return (result == null ? 0 : result);
    }

    private static function parseFloatString(s : String) : Float {
        if (s == null) {
            return 0;
        }

        var result = Std.parseFloat(s);
        return (Math.isNaN(result) ? 0.0 : result);
    }
}
